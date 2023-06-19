extends Spatial

#Quest stats
export (String) var missionName
export (String,MULTILINE) var missionDesc
export (Dictionary) var steps
export (Dictionary) var rewards
var questScene #Cena global

#Holograma stats
export var speedProjector = 1.0
export (NodePath) var cam
export var sceneToBattle = ""
export var sceneNameOnly = ""
var startInteract = false

# Identifica os dialogos feitos no Dialogic
export(String, "TimelineDropdown") var timeline: String
# Adiciona um canvas direto do Dialogic
export(bool) var add_canvas = true
# Checa quando ele pode falar ou nao
var canTalk: bool = false
var clickedOnMe: bool = false
var touchingNPC: bool = false
var player
var mainCam
var pointer
var mat
var acceptQuest = false
var elevators

func _ready():
	cam = get_node(cam)
	mainCam = get_tree().get_nodes_in_group("Camera")[0]
	pointer = get_tree().get_nodes_in_group("Pointer")[0]
	mat = $Base.get_surface_material(0).next_pass
	mat.set_shader_param("enable", false)
	$Arrow.hide()
	$Hologram_Effect.hide()
	$Face.hide()
	$"Base/Projector/Light Volume 2".hide()
	$"Base/Projector/Light Volume 3".hide()
	elevators = get_tree().get_nodes_in_group("Elevator")

func _physics_process(delta):
	if startInteract:
		$Base/Projector.rotate_y(speedProjector * delta)

	# Quando clicar compara se pode conversar
	if Input.is_action_just_pressed("Click"):
		if canTalk:
			clickedOnMe = true
#			pointer.isStopped = true
		else:
			$Arrow.hide()
			mat.set_shader_param("enable", false)
		
		if Input.is_action_just_pressed("ui_select"):
			$Teleporter_Effect.play()
			
	$Arrow.rotate_y(0.1)

func talk_to_player():
	startInteract = true
	cam.current = true
	mainCam.current = false
	$"Base/Projector/Light Volume 2".show()
	$"Base/Projector/Light Volume 3".show()
	player.get_node("Inventory").hide()
	player.get_node("Pause").hide()
	player.get_node("Status").hide()
	owner.get_node("WhiteTransition").hide()
	QuestManager.get_node("Buttons_Diary").hide()
	player.hide()
	pointer.hide()
	yield(get_tree().create_timer(1),"timeout")
	$Hologram_Effect.show()
	QuestManager.get_node("Buttons_Diary").hide()
	yield(get_tree().create_timer(1.5),"timeout")
	$Face.show()
	$AnimationPlayer.play("Start")
	yield(get_tree().create_timer(2),"timeout")
	start_dialogue()

func accept_quest():
	acceptQuest = true
	$AnimationPlayerUI.play("FadeIn")
	GlobalValues.skinChar = "Armadura"
	GlobalValues.whiteScreen = true
	GlobalValues.backToScene = sceneToBattle
	GlobalValues.sceneNameToQuestMNG = sceneNameOnly
	set_quest()

func start_dialogue():
	# Adiciona o dialogo na cena
	var d = Dialogic.start(timeline, '', "res://addons/dialogic/Nodes/DialogNode.tscn", add_canvas)
	get_parent().call_deferred('add_child', d)
	d.connect("dialogic_signal",self,'dialogic_signal')
	
	# Ativa o state Talking do personagem pra ele ficar parado
	player.get_node("States/Talking").visible = true
	pointer.isStopped = true
	pointer.global_transform.origin = player.global_transform.origin
	$Arrow.hide()
	
func dialogic_signal(arg):
	# Quando o signal for emitido ao final do dialogo
	if arg == "cabou" and !acceptQuest:
		player.show()
		cam.current = false
		mainCam.current = true
		player.show()
		player.get_node("Inventory").show()
		player.get_node("Pause").show()
		player.get_node("Status").show()
		owner.get_node("WhiteTransition").show()
		$Arrow.hide()
		mat.set_shader_param("enable", false)
		# Desabilita os controladores do dialogo
		canTalk = false
		clickedOnMe = false
		# Habilita o state Move do player novamente
		player.get_node("States/Talking").visible = false
		player.get_node("States/Move").visible = true
		$AnimationPlayer.play("End")
		
		for i in elevators.size():
			get_tree().get_nodes_in_group("Elevator")[i].owner.goToElevator = false
		
		if QuestManager.isInQuest:
			QuestManager.get_node("Buttons_Diary").show()
		
		yield(get_tree().create_timer(0.1),"timeout")
		pointer.isStopped = false
		yield(get_tree().create_timer(2),"timeout")
		startInteract = false
		$Hologram_Effect.hide()
		
func _on_AreaHologram_mouse_entered():
	# Se o mouse tocar no NPC e ele ja nao estiver em colisão, habilita o dialogo
	if !touchingNPC:
		canTalk = true
		$Arrow.show()
		mat.set_shader_param("enable", true)
		
func _on_AreaHologram_mouse_exited():
	# Quando o mouse sair do NPC e ele nao estiver em dialogo, desativa a interação
	$Arrow.hide()
	if !clickedOnMe:
		canTalk = false
		mat.set_shader_param("enable", false)
		
func _on_AreaHologram_body_entered(body):
	if body.is_in_group("Player"):
		print("Okay")
#		for i in elevators.size():
#			get_tree().get_nodes_in_group("Elevator")[i].owner.goToElevator = true
			
		# Ativa a bool de toque
		touchingNPC = true
		player = body
		# Se o jogador colidir pela primeira vez no NPC o dialogo dispara sozinho
		if clickedOnMe:
			talk_to_player()
			
func _on_AreaHologram_body_exited(body):
	if body.is_in_group("Player"):
		canTalk = false
		touchingNPC = false
		pointer.isStopped = false

func _on_AnimationPlayerUI_animation_finished(anim_name):
	get_tree().change_scene("res://Scenes/Hologram Game/Teleport.tscn")

func set_quest():
	QuestManager.start_quest(missionName,missionDesc,steps)

func end_quest():
	owner.get_node("WhiteTransition/Back").hide()
	QuestManager.get_node("Buttons_Diary").hide()
	QuestManager.get_node("UI").hide()

func show_rewards():
	$Reward_Screen.show()
	$Reward_Screen.set_reward()

