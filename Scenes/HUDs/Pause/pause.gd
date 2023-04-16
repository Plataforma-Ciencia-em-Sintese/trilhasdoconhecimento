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

func _on_BT_Options_pressed():
	$Control_Options/Panel_Options.show()
	$Control_Options/BT_Exit.show()
	$BT_Pause.hide()
	$Panel_Pause.hide()

#Buttons referentes as options

func _on_BT_Exit_pressed():
	$Control_Options/Panel_Options.hide()
	$Control_Options/BT_Exit.hide()
	$BT_Pause.hide()
	$Panel_Pause.show()
	

