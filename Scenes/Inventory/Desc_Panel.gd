extends Panel

func _physics_process(delta):
	set_position(get_global_mouse_position())
