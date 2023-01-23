extends CanvasLayer


func _on_BT_Options_pressed():
	var _Options: bool = get_tree().change_scene("res://Scenes/HUDs/Options/Options.tscn")
	
func _on_Configure_pressed():
	var _Options: bool = get_tree().change_scene("res://Scenes/HUDs/Options/Options.tscn")

func _on_Exit_pressed():
	pass

func _on_Window_toggled(button_pressed):
	OS.window_borderless = button_pressed
	get_tree().get_root()


func _on_Full_toggled(button_pressed):
	OS.window_fullscreen = button_pressed


func _on_800x600_pressed():
	OS.window_size = Vector2(800,600)

func _on_1280x720_pressed():
	OS.window_size = Vector2(1280,720)


func _on_1920x1080_pressed():
	OS.window_size = Vector2(1980,1080)





