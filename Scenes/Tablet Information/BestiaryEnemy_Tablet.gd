extends CanvasLayer

onready var player = get_tree().get_nodes_in_group("Player")[0]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_exit_Enemy_pressed():
	player.get_node("TabletInformation/PanelTablet").show()
	$exit_Enemy.hide()
	$Panel_Enemy.hide()
