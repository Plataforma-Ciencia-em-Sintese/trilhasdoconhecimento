extends Control

export (NodePath) var camera

func _ready() -> void:
	pass


func _on_Play_pressed()-> void:
	var _play: bool = get_tree().change_scene("res://Scenes/Menu/Selection_Zone_3D.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Configure_pressed():
	$Control_Options/Panel_Options.show()
	$Control_Options/BT_Exit.show()
	$Buttons/Play.hide()
	$Buttons/Configure.hide()
	$Buttons/Quit.hide()
	$NameGame.hide()


func _on_BT_Exit_pressed():
	$Control_Options/Panel_Options.hide()
	$Control_Options/BT_Exit.hide()
	$Buttons/Play.show()
	$Buttons/Configure.show()
	#$Buttons/Quit.show()
	$NameGame.show()
