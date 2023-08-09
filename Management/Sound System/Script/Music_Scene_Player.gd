extends Node

# Cada nome da array deve ter o mesmo nome da chave da musica na resource
export (Array,String) var musicName

func _ready():
	GlobalQuest.localScene = self
	GlobalQuest.spawn_item_quest(self)
	
	for i in musicName.size():
		GlobalMusicPlayer.play_sound("start_event",musicName[i])

# SOMENTE PARA TESTES COM AS QUESTS -------------
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_down"):
		GlobalQuest.change_quest("next_quest")
