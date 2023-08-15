extends CanvasLayer

export (NodePath) var logo1
export (NodePath) var logo2
export (NodePath) var logo3
export (float) var speedTransition

func _ready():
	get_node(logo1).show()
	yield(get_tree().create_timer(speedTransition),"timeout")
	get_node(logo1).hide()
	get_node(logo2).show()
	yield(get_tree().create_timer(speedTransition),"timeout")
	get_node(logo2).hide()
	get_node(logo3).show()
	yield(get_tree().create_timer(speedTransition),"timeout")
	WhiteTransition.start_transition("fadein")
	yield(get_tree().create_timer(speedTransition),"timeout")
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
