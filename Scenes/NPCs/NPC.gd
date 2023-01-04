extends KinematicBody

# Identifica os dialogos feitos no Dialogic
export(String, "TimelineDropdown") var timeline: String
# Adiciona um canvas direto do Dialogic
export(bool) var add_canvas = true
# Controla se o NPC deve ter zoom no dialogo
export(bool) var zoom_camera = false
# Checa quando ele pode falar ou nao
var canTalk: bool = false
var clickedOnMe: bool = false
var touchingNPC: bool = false
var player
var mainCam
var pointer
var mat

func _ready():
	mainCam = get_tree().get_nodes_in_group("Camera")[0]
	pointer = get_tree().get_nodes_in_group("Pointer")[0]
	mat = $Base/Root/Skeleton/characterMedium.get_surface_material(0).next_pass
	mat.set_shader_param("enable", false)
	$Arrow.hide()

func _physics_process(delta):
	# Quando clicar compara se pode conversar
	if Input.is_action_just_pressed("Click"):
		if canTalk:
			clickedOnMe = true
			pointer.isStopped = true
			
	$Arrow.rotate_y(0.1)

func start_dialogue():
	# Se o zoom estiver ativo, ativa a camera NPC e esconde o jogador 
	if zoom_camera:
		$Base/Camera.current = true
		mainCam.current = false
		player.hide()
	
	# Adiciona o dialogo na cena
	var d = Dialogic.start(timeline, '', "res://addons/dialogic/Nodes/DialogNode.tscn", add_canvas)
	get_parent().call_deferred('add_child', d)
	d.connect("dialogic_signal",self,'dialogic_signal')
	
	# Ativa o state Talking do personagem pra ele ficar parado
	player.get_node("States/Talking").visible = true
	# Gira o NPC pra posiçao do player
	$Base.look_at(global_transform.origin + player.global_transform.origin.direction_to(global_transform.origin),Vector3.UP)
#	$Base.look_at(transform.origin + player.global_transform.origin.direction_to(transform.origin),Vector3.UP)
	yield(get_tree().create_timer(0.1),"timeout")
	# Gira o player pra posicao do NPC
	player.get_node("Base").look_at(player.global_transform.origin + global_transform.origin.direction_to(player.transform.origin),Vector3.UP)
	# Esconde o ponteiro da cena e o balao da cabeca do NPC
	pointer.hide()
	pointer.global_transform.origin = player.global_transform.origin
	$Arrow.hide()
	
func dialogic_signal(arg):
	# Quando o signal for emitido ao final do dialogo
	if arg == "cabou":
		# Se o zoom estiver ativo, mostra o jogador novamente
		if zoom_camera:
			player.show()
			mainCam.current = true
			$Base/Camera.current = false
			
		$Arrow.hide()
		mat.set_shader_param("enable", false)
		# Desabilita os controladores do dialogo
		canTalk = false
		clickedOnMe = false
		# Habilita o state Move do player novamente
		player.get_node("States/Talking").visible = false
		player.get_node("States/Move").visible = true
		yield(get_tree().create_timer(0.1),"timeout")
		pointer.isStopped = false

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		# Ativa a bool de toque
		touchingNPC = true
		player = body
		# Se o jogador colidir pela primeira vez no NPC o dialogo dispara sozinho
		if clickedOnMe:
			start_dialogue()

func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		canTalk = false
		touchingNPC = false
		pointer.isStopped = false

func _on_Area_mouse_entered():
	# Se o mouse tocar no NPC e ele ja nao estiver em colisão, habilita o dialogo
	if !touchingNPC:
		canTalk = true
		$Arrow.show()
		mat.set_shader_param("enable", true)

func _on_Area_mouse_exited():
	# Quando o mouse sair do NPC e ele nao estiver em dialogo, desativa a interação
	if !clickedOnMe:
		canTalk = false
		$Arrow.hide()
		mat.set_shader_param("enable", false)
