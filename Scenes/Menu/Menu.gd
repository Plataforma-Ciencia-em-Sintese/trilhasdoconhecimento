extends Control

export (NodePath) var camera

func _on_Play_pressed()-> void:
	Fmod.play_one_shot("event:/SFX/Menu/BotaoIniciar", self)
	var _play: bool = get_tree().change_scene("res://Scenes/Menu/Selection_Zone_3D.tscn")

func _on_Quit_pressed():
	get_tree().quit()


func _on_Configure_pressed():
	$Control_Options/Panel_Options.show()
	$Buttons/Play.hide()
	$Buttons/Configure.hide()
	$Buttons/Quit.hide()
	$NameGame.hide()
	

