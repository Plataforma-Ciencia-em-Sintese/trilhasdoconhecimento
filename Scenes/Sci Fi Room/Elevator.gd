extends AnimationPlayer

export (NodePath) var camElevator
export (NodePath) var pointer
export (NodePath) var pointerPos
var goToElevator = false

func _ready():
	camElevator = get_node(camElevator)
	pointer = get_node(pointer)
	pointerPos = get_node(pointerPos)

func _on_Area_Elevator_mouse_entered():
	if !goToElevator:
		play("Door1_Open")
	
func _on_Area_Elevator_mouse_exited():
	if !goToElevator:
		play("Door1_Close")

func _on_Area_Elevator_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("Click") and !goToElevator:
			play("Door1_Open")
			pointer.global_transform.origin = pointerPos.global_transform.origin
			pointer.camera.current = false
			camElevator.current = true
			goToElevator = true
			
