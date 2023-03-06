extends Control

var master_bus = AudioServer.get_bus_index("Master")
export (NodePath) var camera

func _ready() -> void:
	pass

func _on_Who_pressed():
	pass

func _on_Play_pressed()-> void:
	var _play: bool = get_tree().change_scene("res://Scenes/Menu/Selection_Zone_3D.tscn")
	
func _on_Configure_pressed():
	$Options_Layer/Panel_Options.show()
	$Buttons/Play.hide()
	$Buttons/Configure.hide()
	$Buttons/Quit.hide()
	$NameGame.hide()

func _on_Quit_pressed():
	get_tree().quit()

#Buttons referentes as options

func _on_Exit_pressed():
	$Options_Layer/Panel_Options.show()
	$Options_Layer/Panel_Resolution.hide()
	$Buttons/Play.hide()
	$Buttons/Configure.hide()
	$Buttons/Quit.hide()
	$NameGame.hide()


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


func _on_Button_resolution_pressed():
	$Options_Layer/Panel_Resolution.show()
	$Options_Layer/Panel_Options.hide()
	$Buttons/Play.hide()
	$Buttons/Configure.hide()
	$Buttons/Quit.hide()
	$NameGame.hide()


func _on_BT_Exit_pressed():
	$Options_Layer/Panel_Options.hide()
	$Buttons/Play.show()
	$Buttons/Configure.show()
	$Buttons/Quit.show()
	$NameGame.show()
