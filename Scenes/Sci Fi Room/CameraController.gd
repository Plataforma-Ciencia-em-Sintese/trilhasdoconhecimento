extends Camera

export (NodePath) var cam1
export (NodePath) var cam2
var setCam = false

func _physics_process(delta):
	if Input.is_action_just_pressed("R_Click"):
		if !setCam:
			get_tree().get_nodes_in_group("Pointer")[0].camera = get_node(cam2)
			get_node(cam1).current = false
			get_node(cam2).current = true
			setCam = true
		else:
			get_tree().get_nodes_in_group("Pointer")[0].camera = get_node(cam1)
			get_node(cam1).current = true
			get_node(cam2).current = false
			setCam = false
	
func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().get_nodes_in_group("Pointer")[0].camera = get_node(cam2)
		get_node(cam1).current = false
		get_node(cam2).current = true

func _on_Area2_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().get_nodes_in_group("Pointer")[0].camera = get_node(cam1)
		get_node(cam1).current = true
		get_node(cam2).current = false
