extends CanvasLayer

export (NodePath) var camera

func _ready():
 pause_mode = Node.PAUSE_MODE_PROCESS

func _on_Pause_pressed():
	get_tree().paused = true
	$Panel_Pause.show()
	$BT_Pause.hide()

func _on_Exit_pressed():
	get_tree().paused = false
	$BT_Pause.show()
	$Panel_Pause.hide()

func _on_Home_pressed():
	get_tree().paused = false
	var _home: bool = get_tree().change_scene("res://Scenes/Menu/Menu.tscn")


func _on_Options_pressed():
	pass # Replace with function body.
