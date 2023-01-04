extends Spatial

# Velocidade do agente
export (float) var speedWalk = 1
export (float) var speedRun = 1

# Declara quem e o node de navegacao
var navAgent: NavigationAgent

# Declara quem e o node do player
var player: KinematicBody

# Declara quem e o node de animacao
var animator: AnimationTree

# Declara quem e o node do corpo do player
var base: Spatial

# Declara quem e o alvo a ser seguido (no caso o marcador de posicao)
var target: Object

var animationType = 0
var clickCount = 1

func _ready():
	# Identifica quem é o alvo a ser seguido
	# Caso encontre o primeiro elemento encontrado sera o alvo
	target = get_tree().get_nodes_in_group("Pointer")[0]
	
	# Identifica quem é o node de navegacao dentro da cena
	navAgent = owner.get_node("NavigationAgent")
	
	# Identifica o AnimationTree do player
	animator = owner.get_node("AnimationTree")
	
	# Identifica o node base do player que contem os bones
	base = owner.get_node("Base")
	
	# Identifica o KinematicBody do player
	player = owner
	
	# Conecta o signal que calcula a velocidade para desviar de obstaculos moveis
	navAgent.connect("velocity_computed",self, "_on_velocity_computed")
	
	if clickCount == 1:
		navAgent.max_speed = speedWalk
	elif clickCount == 2:
		navAgent.max_speed = speedRun

func _physics_process(delta):
	if is_visible_in_tree():
		move()
	
func move():
	# Mede a distancia entre o personagem e o pointer no cenario
	var distanceToTarget = global_transform.origin.distance_to(target.global_transform.origin) - 0.1

	# Muda de velocidade de acordo com os cliques do mouse
	if Input.is_action_just_pressed("Click") and clickCount < 2:
		clickCount += 1
		if clickCount == 1:
			animationType = -1
		elif clickCount >= 2:
			animationType = 1
		
	if clickCount == 1:
		navAgent.max_speed = speedWalk
		animator.set("parameters/move/blend_amount",-1)
	elif clickCount == 2:
		navAgent.max_speed = speedRun
		animator.set("parameters/move/blend_amount",1)

	# Usa o valor de distancia para mesclar as animacoes, dando um aspecto mais natural de movimentacao
	
	
	# Se o agente encontra seu destino, para de buscar o alvo
	# Isso evita que ele fique "tremendo" quando estiver em cima do alvo
	if navAgent.is_navigation_finished():
		target.hide()
		clickCount = 1
		animator.set("parameters/move/blend_amount",0)
		return
	else:
		#Se o pointer nao estiver dentro de um escondedor dele então é mostrado
		if !target.insideAHider:
			target.show()
		
	# Identifica quem é o alvo, direcao e velocidade de movimento
	var target_pos = navAgent.get_next_location()
	var direction = player.global_transform.origin.direction_to(target_pos)
	var velocity = direction * navAgent.max_speed
	
	# Ajusta a todo momento a velocidade de desvio de obstaculos moveis
	# Quando processado ele chama automaticamente o metodo "_on_velocity_computed"
	navAgent.set_velocity(velocity)
	
	# Faz o personagem olhar para o caminho do navmesh
	get_parent().get_parent().get_node("Base").look_at(player.transform.origin - direction,Vector3.UP)
	
func _on_velocity_computed(new_velocity):
	# Move o personagem assim que o calculo de velocidade é realizado
	player.move_and_slide(new_velocity,Vector3.UP)
	
func _on_NavTimer_timeout():
	# Localiza o alvo a cada x segundos definido no node "Timer"
	navAgent.set_target_location(target.global_transform.origin)
