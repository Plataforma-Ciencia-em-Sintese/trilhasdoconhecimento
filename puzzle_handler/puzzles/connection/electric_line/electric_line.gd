extends Line2D


const _START: int = 1
const _END: int = 0


onready var start_particles: CPUParticles2D = $"%StartParticles"
onready var end_particles: CPUParticles2D = $"%EndParticles"
onready var canvas_layer: CanvasLayer = $"%CanvasLayer"


func change_start(node_position: Vector2) -> void:
	set_point_position(_START, node_position)
	start_particles.position = node_position


func change_end(node_position: Vector2) -> void:
	set_point_position(_END, node_position)
	end_particles.position = node_position


func _on_ElectricLine_visibility_changed() -> void:
	if visible:
		canvas_layer.show()
	else:
		canvas_layer.hide()
