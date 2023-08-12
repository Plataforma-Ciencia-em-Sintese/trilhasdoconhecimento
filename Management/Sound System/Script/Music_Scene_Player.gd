extends Node

# Cada nome da array deve ter o mesmo nome da chave da musica na resource
export (Array,String) var musicName
var stageName : String

func _ready():
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
		# se alguma outra musica tema estiver tocando, manda parar e inicia a da fase
		if musicName[i] == "Cyberspace" and GlobalMusicPlayer.mainMusic != "Cyberspace":
			GlobalMusicPlayer.play_sound("stop_event","PrimeiroNivel")
			GlobalMusicPlayer.play_sound("start_event","Cyberspace")
			musicName.remove(i)
			GlobalMusicPlayer.mainMusic = "Cyberspace"
		elif musicName[i] == "PrimeiroNivel" and GlobalMusicPlayer.mainMusic != "PrimeiroNivel":
			GlobalMusicPlayer.play_sound("stop_event","Cyberspace")
			GlobalMusicPlayer.play_sound("start_event","PrimeiroNivel")
			GlobalMusicPlayer.mainMusic = "PrimeiroNivel"
			musicName.remove(i)
		
		# Se nenhuma musica tema existe na array, toca as sobresalentes
		if musicName.size() > 0:
			if musicName[i] != "Cyberspace" and musicName[i] != "PrimeiroNivel":
				GlobalMusicPlayer.play_sound("start_event",musicName[i])
