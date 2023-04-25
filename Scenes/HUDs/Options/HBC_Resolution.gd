extends HBoxContainer


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
