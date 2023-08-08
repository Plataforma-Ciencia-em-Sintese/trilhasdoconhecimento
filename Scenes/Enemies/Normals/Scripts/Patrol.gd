extends Spatial

export var speed = 1

func _physics_process(delta):
	if is_visible_in_tree():
		owner.get_node("Enemy").rotation_degrees.y = 0
		owner.offset -= speed * delta * 0.5
