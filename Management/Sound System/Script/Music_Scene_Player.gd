extends Node

# Cada nome da array deve ter o mesmo nome da chave da musica na resource
export (Array,String) var musicName

func _ready():
	for i in musicName.size():
			GlobalMusicPlayer.play_sound("start_event",musicName[i])
