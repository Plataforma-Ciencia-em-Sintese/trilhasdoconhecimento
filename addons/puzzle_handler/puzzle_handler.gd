extends Control


signal puzzle_finished(result)


var _child: Control = null


func init_puzzle(scene_path: String) -> void:
	var scene: PackedScene = load(scene_path)
	var puzzle_scene := scene.instance()

	if puzzle_scene is Control:
		if _child == null:
			_child = puzzle_scene

			add_child(_child)

			_child.connect("puzzle_response", self, "_on_Child_puzzle_response")

		else:
			push_error("Puzzle is running!")

	else:
		push_error("A control scene was expected!")


func _on_Child_puzzle_response(result: bool) -> void:
	if result: # Puzzle completed
		emit_signal("puzzle_finished", true)
	else: # Puzzle canceled
		emit_signal("puzzle_finished", false)

		_child.disconnect("puzzle_response", self, "_on_Child_puzzle_response")

		remove_child(_child)

		_child = null


