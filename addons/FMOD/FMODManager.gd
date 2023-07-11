extends Node

var id: int = 0

func _ready() -> void:
	# initialize FMOD
	# initializing with the LIVE_UPDATE flag lets you
	# connect to Godot from the FMOD Studio editor
	# and author events in realtime
	
	id = Fmod.create_event_instance("event:/Musicas/Notaveis/Oswaldo Cruz")
	Fmod.attach_instance_to_node(id, self)
	Fmod.set_event_parameter_by_name(id, "RPM", 600)
	Fmod.set_event_volume(id, 2)
	Fmod.start_event(id)
	Fmod.set_software_format(0, Fmod.FMOD_SPEAKERMODE_STEREO, 0)
	Fmod.init(1024, Fmod.FMOD_STUDIO_INIT_LIVEUPDATE, Fmod.FMOD_INIT_NORMAL)
	# load banks
	# place your banks inside the project directory
	Fmod.load_bank("res://Sounds/Master.strings.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
	Fmod.load_bank("res://Sounds/Master.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
	# register a listener
	Fmod.add_listener(0, self)
	pass

func _input(event):
	if event.is_action_pressed("Click"):
		pass
	if event.is_action_pressed("R_Click"):
		pass
