extends Control

export (NodePath) var camera

func _ready() -> void:
	# initialize FMOD
	# initializing with the LIVE_UPDATE flag lets you
	# connect to Godot from the FMOD Studio editor
	# and author events in realtime
	Fmod.set_software_format(0, Fmod.FMOD_SPEAKERMODE_STEREO, 0)
	Fmod.init(1024, Fmod.FMOD_STUDIO_INIT_LIVEUPDATE, Fmod.FMOD_INIT_NORMAL)
	# load banks
	# place your banks inside the project directory
	Fmod.load_bank("res://Sounds/Master.strings.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
	Fmod.load_bank("res://Sounds/Master.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
	# register a listener
	Fmod.add_listener(0, self)
	pass

	
func _on_Play_pressed()-> void:
	Fmod.play_one_shot("event:/SFX/Menu/BotaoIniciar", self)
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
