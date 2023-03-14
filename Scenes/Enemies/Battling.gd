extends Spatial

export var life = 7
export var distanceToStop = 2
var stop = false
var backToPatrol = false
var startPos = Vector3()
var player
var pathPoint
var navAgent
var getOwner

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	
	getOwner = owner
	
	startPos = getOwner.get_node("Enemy").global_transform.origin
	
	# Identifica quem é o node de navegacao dentro da cena
	navAgent = getOwner.get_node("Enemy/NavigationAgentEnemy")
	
	# Conecta o signal que calcula a velocidade para desviar de obstaculos moveis
	navAgent.connect("velocity_computed",self, "_on_velocity_computed")

func _physics_process(_delta):
	if is_visible_in_tree():
		start_battle()

func start_battle():
	if !backToPatrol:
		var distanceToPlayer = getOwner.get_node("Enemy").global_transform.origin.distance_to(player.global_transform.origin) - 0.1
		if distanceToPlayer <= distanceToStop:
			stop = true
			getOwner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayer").play("Attack")
		else:
			stop = false
			getOwner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayer").play("Idle")
	else:
		var distanceToPatrol = getOwner.get_node("Enemy").global_transform.origin.distance_to(startPos) - 0.1
		if distanceToPatrol <= 1:
			getOwner.offset = 0
			getOwner.unit_offset = 0
			getOwner.disable_looking_collision()
			getOwner.get_node("States/Patrol").show()
			self.hide()
			backToPatrol = true
	
	# Se o agente encontra seu destino, para de buscar o alvo
	# Isso evita que ele fique "tremendo" quando estiver em cima do alvo
	if navAgent.is_navigation_finished():
		return
	
	# Identifica quem é o alvo, direcao e velocidade de movimento
	var target_pos = navAgent.get_next_location()
	var velocity
	var direction
	
	if !backToPatrol:
		direction = player.global_transform.origin.direction_to(target_pos)
		velocity = direction * navAgent.max_speed
	else:
		direction = startPos.direction_to(target_pos)
		velocity = direction * navAgent.max_speed

	# Ajusta a todo momento a velocidade de desvio de obstaculos moveis
	# Quando processado ele chama automaticamente o metodo "_on_velocity_computed"
	navAgent.set_velocity(velocity)
	
	if !backToPatrol:
		# Faz o personagem olhar para o caminho do navmesh
		getOwner.get_node("Enemy/Root_Enemies").look_at(player.transform.origin - direction,Vector3.UP)
	else:
		getOwner.get_node("Enemy/Root_Enemies").look_at(startPos - direction,Vector3.UP)

func _on_velocity_computed(new_velocity):
	if !stop:
		# Move o personagem assim que o calculo de velocidade é realizado
		getOwner.get_node("Enemy").move_and_slide(-new_velocity,Vector3.UP)

func _on_NavTimerEnemy_timeout():
	if !backToPatrol:
		# Localiza o alvo a cada x segundos definido no node "Timer"
		navAgent.set_target_location(player.global_transform.origin)
	else:
		navAgent.set_target_location(getOwner.global_transform.origin)

func _on_Damage_Area_area_entered(area):
	if area.is_in_group("Sword"):
		life -= 1
		getOwner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayerHit").play("Hit")
		if life <= 0:
			player.get_node("States/Battling").end_fight()
			owner.queue_free()
