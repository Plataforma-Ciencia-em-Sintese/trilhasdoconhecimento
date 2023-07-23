extends Node
#
#var iniProjetor: int = 0
#var oswaldoCruz: int = 0
#func _ready() -> void:
#	# initialize FMOD
#	# initializing with the LIVE_UPDATE flag lets you
#	# connect to Godot from the FMOD Studio editor
#	# and author events in realtime
#	Fmod.set_software_format(0, Fmod.FMOD_SPEAKERMODE_STEREO, 0)
#	Fmod.init(1024, Fmod.FMOD_STUDIO_INIT_LIVEUPDATE, Fmod.FMOD_INIT_NORMAL)
#	# load banks
#	# place your banks inside the project directory
#	Fmod.load_bank("res://Sounds/Master.strings.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
#	Fmod.load_bank("res://Sounds/Master.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
#	# register a listener
#
#	# SONS COM LOOP
#	# create an event instance
#	# this is a music event that has been authored in the Studio editor
#	oswaldoCruz = Fmod.create_event_instance("event:/Musicas/Notaveis/Oswaldo Cruz")
#	iniProjetor = Fmod.create_event_instance("event:/SFX/Ingame/InicializandoProjetor")
#
#func _input(event):
#	if event.is_action_pressed("Click"):
#		#Fmod.start_event(iniProjetor)
#		pass
#	if event.is_action_pressed("R_Click"):
#		#Fmod.stop_event(iniProjetor, Fmod.FMOD_STUDIO_STOP_ALLOWFADEOUT)
#		pass
