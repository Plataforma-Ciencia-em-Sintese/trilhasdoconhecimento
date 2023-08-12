extends Node

# Cada nome da array deve ter o mesmo nome da chave da musica na resource
export (Array,String) var musicName
var stageName : String

func _ready():
	GlobalMusicPlayer.play_sound("stop_event","Cyberspace")
	GlobalMusicPlayer.play_sound("stop_event","PrimeiroNivel")
	# Seta a cena local pro script de quest saber onde o jogador esta
	GlobalQuest.localScene = self
	# Confere se a cena participa de alguma quest
	stageName = get_tree().get_current_scene().get_name()
	if GlobalQuest.questResource != null:
		print(get_tree().get_current_scene().get_name())
		print(GlobalQuest.questResource.sceneToCreateItem)
		if GlobalQuest.questResource.sceneToCreateItem == stageName:
			GlobalQuest.spawn_item_quest(self)
	
	for i in musicName.size():
		GlobalMusicPlayer.play_sound("start_event",musicName[i])
