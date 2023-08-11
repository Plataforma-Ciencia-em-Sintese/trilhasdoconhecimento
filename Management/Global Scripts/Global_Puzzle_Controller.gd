extends Node

var nodeHandler : String = "res://addons/puzzle_handler/puzzle_handler.tscn"
var rootAllPuzzles : String = "res://addons/puzzle_handler/puzzles/"
var player : Node
var wall : Node
var actualPuzzle : String

func call_puzzle(name):
	var newPuzzle = load(nodeHandler).instance()
	newPuzzle.init_puzzle(rootAllPuzzles + name + "/" + name + ".tscn")
	newPuzzle.connect("puzzle_finished",self,"result_puzzle")
	add_child(newPuzzle)
	actualPuzzle = name
	
func result_puzzle(status):
	if status:
		Dialogic.set_variable(actualPuzzle,"true")
		wall.queue_free()
	
	pause_player(false)

func pause_player(status):
	if status:
		player.get_node("States/Move").hide()
		player.get_node("States/Talking").show()
	else:
		player.get_node("States/Move").show()
		player.get_node("States/Talking").hide()
