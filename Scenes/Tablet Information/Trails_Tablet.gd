extends CanvasLayer

onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	pass # Replace with function body.


func _on_exit_Trails_pressed():
	player.get_node("TabletInformation/PanelTablet").show()
	$exit_Trails.hide()
	$Panel_trails.hide()
