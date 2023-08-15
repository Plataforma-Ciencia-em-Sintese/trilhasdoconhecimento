extends Node

# armazena a quest atual
var actualQuest : String = "Quest_01"
# Checa se existe uma interface criada pra contar os itens
var hasCountUI : bool = false
# SOMENTE USADA SE FOR PEGAR ITENS (nao instancia direto no jogo)
var startedAQuest : bool = false
# Recebe o node NPC que ta falando
var whoIsTalking : Node
# Ui de contagem dos itens a serem pegos
var itemCountUI : String = "res://Scenes/Item/UI/Item_Count_UI.tscn"
# Painel de alerta para dizer quando uma missao foi finalizada
var panelAlert : String = "res://Scenes/General UI/Alert Panel/Alert_Panel.tscn"
# Painel de recompensa ao finalizar a quest
var panelReward : String = "res://Scenes/Reward Screen/Reward_UI.tscn"
# Essa cena vem da local que tem o script de musica
# Usada para criar itens na cena caso precise
var localScene : Node
# Diretorio de onde ficam os controladores de quest
var questDir : String = "res://Scenes/Quest Manager/Resource Quest/Controllers/"
# Resource da quest para ser comparado com as cenas locais se pode criar itens ou nao
var questResource : Resource
# Avisa ao tablet de infos que a quest iniciou com as informacoes basicas
signal QuestInfos(title,desc)
# Armazena as infos da quest para toda vez que trocar de cena o tablet acessar aqui
var titleQuest : String = "Inicie a próxima quest"
var descQuest : String = "O quadro de informações irá atualizar assim que uma nova quest se iniciar."

# SOMENTE PARA TESTES COM AS QUESTS -------------
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_down"):
		change_quest("next_quest")
		
# chamada do dialogic
func start_dialogue(dial):
	var d = Dialogic.start(dial, '', "res://addons/dialogic/Nodes/DialogNode.tscn", true)
	get_parent().call_deferred('add_child', d)
	d.connect("dialogic_signal",self,'dialogic_signal')

# finalizacao do dialogic
# os eventos devem existir na propria ferramenta
func dialogic_signal(arg):
	# Quando um dialogo comum acaba ----
	if arg == "cabou":
		whoIsTalking.end_dialogue()
	# Quando a quest termina e tinha itens pra pegar ----
	elif arg == "end_quest_with_item":
		# Libera para ser criado uma nova interface na proxima quest caso haja coleta de itens
		hasCountUI = false
		startedAQuest = false
		questResource = null
	# Quando a quest inicia e tem itens pra pegar ----
	elif arg == "start_quest_with_item":
		# Pra nao spawnar itens antes mesmo de começar a quest
		startedAQuest = true
		# Armazena o resource da quest aceita
		questResource = get_files_in_directory(questDir)[0]
		# Compara se na cena atual e onde deve criar os itens
		if localScene.stageName == questResource.sceneToCreateItem:
			spawn_item_quest(localScene)
		# Emite o sinal para o tablet de infos
		emit_signal("QuestInfos",questResource.title,questResource.description)
		titleQuest = questResource.title
		descQuest = questResource.description
	# Inicia a quest sem itens para pegar
	elif arg == "start_quest_normal":
		questResource = get_files_in_directory(questDir)[0]
		# Emite o sinal para o tablet de infos
		emit_signal("QuestInfos",questResource.title,questResource.description)
		titleQuest = questResource.title
		descQuest = questResource.description
	# Quando o jogador ganha recompensas ----
	elif arg == "give_reward":
		# Carrega o painel de vitoria e a resource da quest atual
		var reward = load(panelReward).instance()
		
		# Se tiver recompensas, manda pro painel
		if questResource.rewards.size() > 0:
			for i in questResource.rewards.size():
				reward.resourcesToShow.append(questResource.rewards[i])
		 
		# Da o xp da quest ao jogador
		GlobalXp.set_xp(questResource.xpQuest)
		reward.xpQuest = questResource.xpQuest
		# Add o painel na cena
		localScene.add_child(reward)
	# Quando deve seguir para a proxima quest
	elif arg == "next_quest":
		change_quest(arg)
	# Inicia o puzzle connection
	elif arg == "connection":
		GlobalPuzzleController.call_puzzle(arg)
	# Termina um puzzle
	elif arg == "end_puzzle":
		GlobalPuzzleController.pause_player(false)
		
# funcao chamada dos nodes da cena local
func spawn_item_quest(scene):
	# Checa cada quest pra saber o que fazer caso a cena mude e tenha coisas a fazer ainda
	# Checa se a missao esta ativa
	if actualQuest == "Quest_01" and startedAQuest:
		if Dialogic.get_variable("Quest_01_Status") == "started":
			# Carrega a cena dos itens pre setados alem da interface de contagem
			var item = questResource.itemToGetScene.instance()
			# Se ele nao tiver uma interface, cria uma nova
			if !hasCountUI:
				var uiCount = load(itemCountUI).instance()
				# Para cada item, conecta o signal de quando o player toca nele pro painel de contagem
				for i in item.get_child_count():
					item.get_child(i).connect("change_value",uiCount,"change_ui")
					item.get_child(i).isInQuest = true
				# Seta as variaveis pro script dos itens UI
				uiCount.questVariable = "Quest_01_Values"
				uiCount.alertPanel = panelAlert
				uiCount.msg = questResource.winTxtToItem
				
				# O item add na cena, mas o painel fica no global pois evita das informacoes
				# serem resetadas quando mudar de cena
				# Ele leva tambem a contagem total de itens ja pegos e preseta a contagem certa
				# quando o jogador muda e volta pra cena dos itens por exemplo
				get_tree().root.call_deferred("add_child",uiCount)
				hasCountUI = true
			else:
				# Se ja existe a UI, coleta dela os valores antigos pra setar a quantidade certa dos itens
				for i in get_tree().root.get_node("Item_Count").count:
					item.get_child(i).queue_free()
					
				for i in item.get_child_count():
					item.get_child(i).connect("change_value",get_tree().root.get_node("Item_Count"),"change_ui")
					item.get_child(i).isInQuest = true
			
			# Add a cena corrigida para o jogo
			scene.add_child(item)
	elif actualQuest == "Quest_03" and startedAQuest:
		if Dialogic.get_variable("Quest_03_Status") == "active":
			# Carrega a cena dos itens pre setados alem da interface de contagem
			var item = questResource.itemToGetScene.instance()
			# Se ele nao tiver uma interface, cria uma nova
			if !hasCountUI:
				var uiCount = load(itemCountUI).instance()
				# Para cada item, conecta o signal de quando o player toca nele pro painel de contagem
				for i in item.get_child_count():
					item.get_child(i).connect("change_value",uiCount,"change_ui")
					item.get_child(i).isInQuest = true
				# Seta as variaveis pro script dos itens UI
				uiCount.questVariable = "Quest_03_Values"
				uiCount.alertPanel = panelAlert
				uiCount.msg = questResource.winTxtToItem
				
				# O item add na cena, mas o painel fica no global pois evita das informacoes
				# serem resetadas quando mudar de cena
				# Ele leva tambem a contagem total de itens ja pegos e preseta a contagem certa
				# quando o jogador muda e volta pra cena dos itens por exemplo
				get_tree().root.call_deferred("add_child",uiCount)
				hasCountUI = true
			else:
				# Se ja existe a UI, coleta dela os valores antigos pra setar a quantidade certa dos itens
				for i in get_tree().root.get_node("Item_Count").count:
					item.get_child(i).queue_free()
					
				for i in item.get_child_count():
					item.get_child(i).connect("change_value",get_tree().root.get_node("Item_Count"),"change_ui")
					item.get_child(i).isInQuest = true
			
			# Add a cena corrigida para o jogo
			scene.add_child(item)

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
		elif file.get_basename() == actualQuest:
			files.append(load(path + "/" + actualQuest + ".tres"))
	
	dir.list_dir_end()
	return files

# Dialogic chama aqui para mudar para outra quest
# Pega a numeracao final da resource quest, aumenta ou diminui 1 e preseta o novo nome como QUEST_XX
func change_quest(quest):
	if quest == "next_quest":
		var numeralQuest = actualQuest[7]
		var decimalQuest = actualQuest[6]
		var join = decimalQuest + numeralQuest
		var newValue = int(join) + 1
		
		if newValue <= 9:
			actualQuest = "Quest_0" + str(newValue)
		else:
			actualQuest = "Quest_" + str(newValue)
		
		emit_signal("QuestInfos","Inicie a próxima quest","O quadro de informações irá atualizar assim que uma nova quest se iniciar.")
		titleQuest = questResource.title
		descQuest = questResource.description
		print(actualQuest)
