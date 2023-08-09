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
# Essa cena vem da local que tem o script de musica
# Usada para criar itens na cena caso precise
var localScene : Node

# chamada do dialogic
func start_dialogue(dial):
	var d = Dialogic.start(dial, '', "res://addons/dialogic/Nodes/DialogNode.tscn", true)
	get_parent().call_deferred('add_child', d)
	d.connect("dialogic_signal",self,'dialogic_signal')

# finalizacao do dialogic
# os eventos devem existir na propria ferramenta
# E chama o end dialogue do node do NPC
func dialogic_signal(arg):
	if arg == "cabou":
		whoIsTalking.end_dialogue()
	elif arg == "end_quest_with_item":
		# Libera para ser criado uma nova interface na proxima quest caso haja coleta de itens
		hasCountUI = false
		startedAQuest = false
	elif arg == "start_quest_with_item":
		# Pra nao spawnar itens antes mesmo de começar a quest
		startedAQuest = true
		spawn_item_quest(localScene)

# funcao chamada dos nodes da cena local
func spawn_item_quest(scene):
	# Checa cada quest pra saber o que fazer caso a cena mude e tenha coisas a fazer ainda
	# Checa se a missao esta ativa
	if actualQuest == "Quest_02" and startedAQuest:
		if Dialogic.get_variable("Quest_02_Status") == "active":
			# Carrega a cena dos itens pre setados alem da interface de contagem
			var item = load("res://Scenes/Item/Quest to Scene/Item_Quest_02.tscn").instance()
			# Se ele nao tiver uma interface, cria uma nova
			if !hasCountUI:
				var uiCount = load(itemCountUI).instance()
				# Para cada item, conecta o signal de quando o player toca nele pro painel de contagem
				for i in item.get_child_count():
					item.get_child(i).connect("change_value",uiCount,"change_ui")
				# Seta as variaveis pro script dos itens UI
				uiCount.questVariable = "Quest_02_Values"
				uiCount.alertPanel = panelAlert
				uiCount.msg = " Foi bem massa essa missão kkk"
				
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
			
			# Add a cena corrigida para o jogo
			scene.add_child(item)


