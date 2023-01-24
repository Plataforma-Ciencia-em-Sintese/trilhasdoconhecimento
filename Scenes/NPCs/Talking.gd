extends Spatial

export (NodePath) var animationTree

func idle():
	owner.get_node("NPC/States/Normal").speed = 0
	get_node(animationTree).get("parameters/moving/playback").travel("Idle")
