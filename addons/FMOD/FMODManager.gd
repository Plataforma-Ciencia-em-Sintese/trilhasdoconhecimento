extends Node


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
	
	# create an event instance
	# this is a music event that has been authored in the Studio editor
	var my_music_event = Fmod.create_event_instance("event:/Musicas/Notaveis/Oswaldo Cruz")

	pass
	
func _process(delta):
	# update FMOD every tick
	# calling system_update also updates the listener 3D position
	# and 3D positions of any attached event instances
	Fmod.system_update()
	
	
func _input(event):
	if event.is_action_pressed("Click"):
		pass
	if event.is_action_pressed("R_Click"):
		pass
