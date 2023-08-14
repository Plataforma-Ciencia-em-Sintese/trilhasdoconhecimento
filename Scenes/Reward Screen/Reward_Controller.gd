extends CanvasLayer

# Coleta a resource da recompensa que vem do Global Quest
export (Array,Resource) var resourcesToShow
# Identifica a interface base das rewards
export (PackedScene) var baseUI 
# Chama o inventario pra setar os novos itens
onready var inventory : Node = get_tree().get_nodes_in_group("Inventory")[0]
# Musica tema desse node
export (String) var musicName
# Recebe o XP da quest pra mostrar a tela pelo GlobalQuest
var xpQuest : float

func _ready():
	get_tree().paused = true
	
	# Toca a musica tema
	if musicName != "":
		GlobalMusicPlayer.play_sound("set_global",1)
		GlobalMusicPlayer.play_sound("start_event",musicName)
	
	# Pra cada recompensa, mostra a info na tela
	# Aproveita e muda o status pra desbloqueado da resource
	for i in resourcesToShow.size():
		var ui = baseUI.instance()
		ui.get_node("Icon_Item").texture = resourcesToShow[i].icon
		ui.get_node("BG_Title_Item/Title_Type").text = resourcesToShow[i].name + "\n" + resourcesToShow[i].description
		$Container_Rewards.add_child(ui)
		resourcesToShow[i].unlocked = true

	# Pede pro inventario recriar os itens atualizados
	inventory.delete_itens_to_rewards()
	inventory.start_inventory()
	
	$BG/XP_Txt.text = "XP +" + str(xpQuest)
	
func _on_Button_pressed():
	get_tree().paused = false
	
	if musicName != "":
		GlobalMusicPlayer.play_sound("set_global",0)
		GlobalMusicPlayer.play_sound("stop_event",musicName)
		
	queue_free()
