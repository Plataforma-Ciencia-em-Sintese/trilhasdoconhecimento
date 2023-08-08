extends Node

var musicResource : Resource = preload("res://Management/Sound System/Music Controllers/Music_Controller.tres")

func play_sound(event,value):
	if event == "start_event":
		Fmod.start_event(Fmod.get_node("FmodAtributos").get(musicResource.music[value]))
	elif event == "play_one":
		Fmod.play_one_shot(value,self)
	elif event == "set_global":
		Fmod.set_global_parameter_by_name("Holo", value)
	elif event == "stop_event":
		Fmod.stop_event(Fmod.get_node("FmodAtributos").get(musicResource.music[value]),Fmod.FMOD_STUDIO_STOP_ALLOWFADEOUT)
