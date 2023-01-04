extends MeshInstance

export (float) var speed = 2.0
var mat = get_surface_material(0)

func _physics_process(delta):
	mat.uv1_offset.x += speed * delta
