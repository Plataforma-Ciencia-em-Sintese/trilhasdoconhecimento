extends MeshInstance

var speed = 0.2

func _physics_process(delta):
	rotate_y(speed * delta)