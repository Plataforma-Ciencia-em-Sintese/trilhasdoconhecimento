extends Node

# Coleta as musicas dentro da resource
# Cada nome da array deve ter o mesmo nome da chave da musica na resource
export (Array,String) var musicName
export (Resource) var musicResource

func _ready():
	# Se tem resource, busca a musica dentro do FMOD Manager pela string da array
	if musicResource != null:
		for i in musicName.size():
			Fmod.start_event(Fmod.get_node("FmodAtributos").get(musicResource.music[musicName[i]]))

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_down"):
		set_music_mode("SetMainMusicVol",1)
		set_music_mode("PlayNPCMusic","Galileu")
	elif Input.is_action_just_pressed("ui_up"):
		set_music_mode("StopNPCMusic","Galileu")
		set_music_mode("SetMainMusicVol",0)

func set_music_mode(param,value):
	# Checa se e para controlar a musica principal
	if param == "SetMainMusicVol":
		 Fmod.set_global_parameter_by_name("Holo", value)
	# Checa se e para controlar a musica tema dos npcs
	elif param == "PlayNPCMusic":
		Fmod.start_event(Fmod.get_node("FmodAtributos").get(musicResource.music[value]))
	elif param == "StopNPCMusic":
		Fmod.stop_event(Fmod.get_node("FmodAtributos").get(musicResource.music[value]), Fmod.FMOD_STUDIO_STOP_ALLOWFADEOUT)
