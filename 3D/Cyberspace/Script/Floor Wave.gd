extends MeshInstance

export var direction = Vector3()
var mat = get_surface_material(0)

func _physics_process(delta):
	print(mat)
	mat.uv1_offset += direction * delta
