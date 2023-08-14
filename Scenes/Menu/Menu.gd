extends Control

export (NodePath) var camera

func _ready():
	WhiteTransition.start_transition("fadeout")

func _on_Play_pressed()-> void:
	Fmod.play_one_shot("event:/SFX/Menu/BotaoIniciar", self)
	get_tree().change_scene("res://Scenes/Menu/Selection_Zone_3D.tscn")

func _on_Configure_pressed():
	$Control_Options/Panel_Options.show()
	$Buttons/Play.hide()
	$Buttons/Configure.hide()
	$NameGame.hide()
	$Buttons/Sobre.hide()
	
func _on_Sobre_pressed():
	$Creditos/Panel_creditos.show()
	$Buttons/Play.hide()
	$Buttons/Configure.hide()
	$NameGame.hide()
	$Buttons/Sobre.hide()
