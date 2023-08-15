extends PathFollow

# Controla se o NPC deve ter zoom no dialogo
export(bool) var zoomCamera = false

# Customizacao NPC
export (String, "Moreno", "Loiro", "Amarelo") var corpo
export (String, "Feminino", "Masculino") var cabelo
export (String, "Longa", "Curta") var mangas

# Nome do NPC (Deve ser o msm do dialogic)
export (String) var npcName

# Diretorio de onde ficam os controladores de quest
var questDir : String = "res://Scenes/Quest Manager/Resource Quest/Controllers/"

# Se o npc tiver musica propria
export (bool) var haveMusicTheme

export (bool) var showExclamation
var haveExclamation : bool = false

# Checa quando ele pode falar ou nao
var canTalk: bool = false

# Controle de interacao com o player
var clickedOnMe: bool = false
var touchingNPC: bool = false

# Nodes da cena
onready var talkingState : Node = $NPC/States/Talking
onready var normalState : Node = $NPC/States/Normal
onready var arrow : Node = $NPC/Arrow
onready var skeletonBaseNpc : Node = $NPC/Base
onready var baseCam : Node = $NPC/Base/Camera
onready var player : Node = get_tree().get_nodes_in_group("Player")[0]
onready var mainCam : Node = get_tree().get_nodes_in_group("Camera")[0]
onready var pointer : Node = get_tree().get_nodes_in_group("Pointer")[0]
onready var mat : Material = $NPC/Base/Cientistas/Skeleton/NPC_Body.get_surface_material(0).next_pass


func _ready():
	# Preseta todo o design desse NPC
	mat.set_shader_param("enable", false)
	arrow.hide()
	
	$NPC/Base/Cientistas/Skeleton/Cabeca.get_node(corpo).show()
	$NPC/Base/Cientistas/Skeleton/Cabelo.get_node(cabelo).get_node(corpo).show()
	$NPC/Base/Cientistas/Skeleton/Manga.get_node(mangas).get_node(corpo).show()
	
	if showExclamation:
		$NPC/Exclamation.show()
		haveExclamation = true
	else:
		$NPC/Exclamation.hide()
	
func _physics_process(_delta):
	# Quando clicar compara se pode conversar
	if Input.is_action_just_pressed("Click"):
		if canTalk:
			clickedOnMe = true
		else:
			arrow.hide()
			mat.set_shader_param("enable", false)
			
	arrow.rotate_y(0.1)

func start_dialogue():
	# Toca a musica do mundo e para o tema do NPC
	if haveMusicTheme:
		GlobalMusicPlayer.play_sound("set_global",1)
		GlobalMusicPlayer.play_sound("start_event",npcName)
	
	# Se o zoom estiver ativo, ativa a camera NPC e esconde o jogador 
	if zoomCamera:
		baseCam.current = true
		mainCam.current = false
		player.get_node("States/Talking").visible = true
		player.get_node("States/Move").visible = false
		yield(get_tree().create_timer(0.1),"timeout")
		player.hide()

	# Ativa o state Talking do personagem pra ele ficar parado
	player.get_node("States/Talking").visible = true
	# Gira o NPC pra posiçao do player
	skeletonBaseNpc.look_at(global_transform.origin + player.global_transform.origin.direction_to(global_transform.origin),Vector3.UP)
	# Offset de rotação no eixo x para NPC ficar em pé
	skeletonBaseNpc.rotation_degrees.x += 10
	yield(get_tree().create_timer(0.1),"timeout")
	# Gira o player pra posicao do NPC
	player.get_node("Base").look_at(player.global_transform.origin + global_transform.origin.direction_to(player.transform.origin),Vector3.UP)
	# Esconde o ponteiro da cena e o balao da cabeca do NPC
	pointer.hide()
	pointer.global_transform.origin = player.global_transform.origin
	arrow.hide()
	$NPC/Exclamation.hide()
	
func end_dialogue():
	# Se o zoom estiver ativo, mostra o jogador novamente
	if zoomCamera:
		mainCam.current = true
		baseCam.current = false
		player.show()
		
	arrow.hide()
	normalState.show()
	
	if haveExclamation:
		$NPC/Exclamation.show()
	
	normalState.lockMovingArround = false
	mat.set_shader_param("enable", false)
	# Desabilita os controladores do dialogo
	canTalk = false
	clickedOnMe = false
	# Habilita o state Move do player novamente
	player.get_node("States/Talking").visible = false
	player.get_node("States/Move").visible = true
	#Reativa o npc para o estado que estava e reseta a rotação
	normalState.state_npc(normalState.states)
	skeletonBaseNpc.rotation_degrees = Vector3.ZERO
	yield(get_tree().create_timer(0.1),"timeout")
	pointer.isStopped = false
	# Toca a musica do mundo e para o tema do NPC
	if haveMusicTheme:
		GlobalMusicPlayer.play_sound("set_global",0)
		GlobalMusicPlayer.play_sound("stop_event",npcName)

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		# Ativa a bool de toque
		touchingNPC = true
		player = body
		# Se o jogador colidir pela primeira vez no NPC o dialogo dispara sozinho
		if clickedOnMe:
			# Se existe quest ativa, chama a fala do NPC dela pelo seu nome
			if GlobalQuest.actualQuest != "":
				var quests_controllers = get_files_in_directory(questDir)
				check_NPC_quest(quests_controllers)
			else:
				GlobalQuest.start_dialogue(npcName)
			
			GlobalQuest.whoIsTalking = self
			talkingState.idle()
			normalState.hide()
			normalState.get_node("Timer").stop()
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
		arrow.show()
		mat.set_shader_param("enable", true)

func _on_Area_mouse_exited():
	# Quando o mouse sair do NPC e ele nao estiver em dialogo, desativa a interação
	arrow.hide()
	if !clickedOnMe:
		canTalk = false
		mat.set_shader_param("enable", false)

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
