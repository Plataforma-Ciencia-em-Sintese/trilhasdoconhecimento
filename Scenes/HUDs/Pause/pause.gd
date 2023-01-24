extends CanvasLayer


var master_bus = AudioServer.get_bus_index("Master")
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
	$Panel_Options.show()
	$BT_Pause.hide()
	$Panel_Pause.hide()

#Buttons referentes as options

func _on_BT_Exit_pressed():
	$Panel_Options.hide()
	$BT_Pause.hide()
	$Panel_Pause.show()

func _on_Window_toggled(button_pressed):
	OS.window_borderless = button_pressed
	get_tree().get_root()


func _on_Full_toggled(button_pressed):
	OS.window_fullscreen = button_pressed
	get_tree().get_root()


func _on_800x600_pressed():
	OS.window_size = Vector2(800,600)
	get_tree().get_root()


func _on_1280x720_pressed():
	OS.window_size = Vector2(1280,720)
	get_tree().get_root()


func _on_1920x1080_pressed():
	OS.window_size = Vector2(1980,1080)
	get_tree().get_root()


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_bus,true)
	else:
		AudioServer.set_bus_mute(master_bus,false)
