extends CanvasLayer

onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	pass


func _on_exit_Notables_pressed():
	$exit_Notables.hide()
	$Panel_Notables.hide()
	player.get_node("Battle_UI").show()
	player.get_node("MiniMap_UI").show()
	player.get_node("Status").show()
	player.get_node("States/Move").show()
	player.get_node("TabletInformation/BT_tablet").show()
	get_tree().paused = false


func _on_Panel_exit_pressed():
	$exit_Notables.hide()
	$Panel_Notables.hide()
	player.get_node("Battle_UI").show()
	player.get_node("MiniMap_UI").show()
	player.get_node("Status").show()
	player.get_node("States/Move").show()
	player.get_node("TabletInformation/BT_tablet").show()
	get_tree().paused = false


func _on_BT_Voltar_pressed():
	player.get_node("TabletInformation/PanelTablet").show()
	$exit_Notables.hide()
	$Panel_Notables.hide()
