extends CanvasLayer

onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	pass # Replace with function body.


func _on_exit_Notables_pressed():
	player.get_node("TabletInformation/PanelTablet").show()
	$exit_Notables.hide()
	$Panel_Notables.hide()


func _on_Panel_exit_pressed():
	player.get_node("TabletInformation/PanelTablet").show()
	$exit_Notables.hide()
	$Panel_Notables.hide()
