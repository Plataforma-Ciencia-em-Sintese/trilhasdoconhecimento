extends Control

func _ready() -> void:
	pass

func _on_Who_pressed():
	pass

func _on_Play_pressed():
	
	var _play: bool = get_tree().change_scene("res://Scenes/Sci Fi Room/Debug_Room.tscn")

func _on_Configure_pressed():
	var _configure: bool = get_tree().change_scene("res://Scenes/Sci Fi Room/Debug_Room.tscn")

func _on_Quit_pressed():
	get_tree().quit()
