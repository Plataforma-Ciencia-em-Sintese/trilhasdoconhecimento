extends Area

export (String, "connection") var puzzles

func _ready():
	$Wall.hide()

func _on_Puzzle_Wall_body_entered(body):
	if body.is_in_group("Player"):
		GlobalPuzzleController.player = body
		GlobalPuzzleController.wall = self
		GlobalPuzzleController.pause_player(true)
		GlobalQuest.start_dialogue(puzzles)
