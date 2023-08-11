extends Node

# Cada nome da array deve ter o mesmo nome da chave da musica na resource
export (Array,String) var musicName
var stageName : String
onready var puzzle_handler = $"%PuzzleHandler"

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
		GlobalMusicPlayer.play_sound("start_event",musicName[i])

#	puzzle_handler.init_puzzle("res://puzzle_handler/puzzles/connection/connection.tscn")

func _on_PuzzleHandler_puzzle_finished(result):
	if result:
		print("passou")
	else:
		print("faleceu")
