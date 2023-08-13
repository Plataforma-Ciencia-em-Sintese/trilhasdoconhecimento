extends MeshInstance

var speed = 0.6

func _physics_process(delta):
	rotate_y(speed * delta)
