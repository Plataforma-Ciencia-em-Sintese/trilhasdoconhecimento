extends Spatial

export (String) var npcName
#Holograma stats
export var speedProjector = 1.0
export (NodePath) var cam
var startInteract = false

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

# Diretorio de onde ficam os controladores de quest
var questDir : String = "res://Scenes/Quest Manager/Resource Quest/Controllers/"

func _ready():
	cam = get_node(cam)
	mainCam = get_tree().get_nodes_in_group("Camera")[0]
	pointer = get_tree().get_nodes_in_group("Pointer")[0]
	mat = $Base.get_surface_material(0).next_pass
	mat.set_shader_param("enable", false)
	$Arrow.hide()
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
#	Fmod.start_event(Fmod.get_node("FmodAtributos").iniProjetor)
	startInteract = true
	cam.current = true
	mainCam.current = false
	$"Base/Projector/Light Volume 2".show()
	$"Base/Projector/Light Volume 3".show()
	player.get_node("Inventory").hide()
	player.get_node("TabletInformation").hide()
	player.get_node("MiniMap_UI").hide()
	player.get_node("Battle_UI").hide()
	player.get_node("Status").hide()
	player.get_node("States/Move").hide()
	player.get_node("States/Talking").show()
	owner.get_node("WhiteTransition").hide()
	pointer.hide()
	
	if npcName != "":
		GlobalMusicPlayer.play_sound("set_global",1)
		GlobalMusicPlayer.play_sound("start_event",npcName)
		
	yield(get_tree().create_timer(0.05),"timeout")
	player.hide()
	yield(get_tree().create_timer(1),"timeout")
	GlobalMusicPlayer.play_sound("start_event","InicializandoProjetor")
	yield(get_tree().create_timer(1.5),"timeout")
	$Face.show()
	$AnimationPlayer.play("Start")
	yield(get_tree().create_timer(2),"timeout")
	start_dialogue()

func start_dialogue():
	if GlobalQuest.actualQuest != "":
		var quests_controllers = get_files_in_directory(questDir)
		check_NPC_quest(quests_controllers)
	else:
		GlobalQuest.start_dialogue(npcName)
	
	# Ativa o state Talking do personagem pra ele ficar parado
	player.get_node("States/Talking").visible = true
	pointer.isStopped = true
	pointer.global_transform.origin = player.global_transform.origin
	$Arrow.hide()
	
func end_dialogue():
	# Quando o signal for emitido ao final do dialogo
	if npcName != "":
		GlobalMusicPlayer.play_sound("set_global",0)
		GlobalMusicPlayer.play_sound("stop_event",npcName)
	
	GlobalMusicPlayer.play_sound("stop_event","InicializandoProjetor")
	player.show()
	cam.current = false
	mainCam.current = true
	player.show()
	player.get_node("Inventory").show()
	player.get_node("TabletInformation").show()
	player.get_node("MiniMap_UI").show()
	player.get_node("Battle_UI").show()
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
	yield(get_tree().create_timer(0.1),"timeout")
	pointer.isStopped = false
	yield(get_tree().create_timer(2),"timeout")
	startInteract = false
		
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
		# Ativa a bool de toque
		touchingNPC = true
		player = body
		# Se o jogador colidir pela primeira vez no NPC o dialogo dispara sozinho
		if clickedOnMe:
			talk_to_player()
			GlobalQuest.whoIsTalking = self
			
func _on_AreaHologram_body_exited(body):
	if body.is_in_group("Player"):
		canTalk = false
		touchingNPC = false
		pointer.isStopped = false

func get_files_in_directory(path):
	# funcao que acessa a pasta especificada e coleta todos os .tres ja carregados
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif file.get_basename() == GlobalQuest.actualQuest:
			files.append(load(path + "/" + GlobalQuest.actualQuest + ".tres"))
	
	dir.list_dir_end()
	return files

func check_NPC_quest(questRes):
	# Procura na resource de fala o dialogo do npc se caso ele fizer parte
	# O nome do npc deve ser o mesmo da resource senao ele nao chama
	var founded : bool
	
	for i in questRes[0].actors.keys().size():
		if questRes[0].actors.keys()[i] == npcName:
			GlobalQuest.start_dialogue(questRes[0].actors[npcName])
			founded = true
			break
		else:
			founded = false
			
	if !founded:
		GlobalQuest.start_dialogue(npcName)
