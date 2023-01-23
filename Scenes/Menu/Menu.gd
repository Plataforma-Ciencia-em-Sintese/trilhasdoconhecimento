extends Control

func _ready() -> void:
	pass

func _on_Who_pressed():
	pass

func _on_Play_pressed():
	var _play: bool = get_tree().change_scene("res://Scenes/Sci Fi Room/Debug_Room.tscn")

func _on_Configure_pressed():
	$Options_Layer.show()
	$Buttons/Play.hide()
	$Buttons/Configure.hide()
	$Buttons/Quit.hide()
	$development.hide()
	$NameGame.hide()

func _on_Quit_pressed():
	get_tree().quit()

#Buttons referentes as options

func _on_Exit_pressed():
	$Options_Layer.hide()
	$Buttons/Play.show()
	$Buttons/Configure.show()
	$Buttons/Quit.show()
	$development.show()
	$NameGame.show()


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
