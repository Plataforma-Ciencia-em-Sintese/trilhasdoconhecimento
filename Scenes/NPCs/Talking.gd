extends Spatial

export (NodePath) var animationTree

func idle():
	owner.offset = 0
	get_node(animationTree).get("parameters/moving/playback").travel("Idle")
