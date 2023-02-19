extends Camera

export (NodePath) var anchorCam1
export (NodePath) var anchorCam2
export (NodePath) var cam1
var anchorGeral
var setCam = false
var lookToPlayer = false
var geralLerp = false

func _ready():
	anchorCam1 = get_node(anchorCam1)
	anchorCam2 = get_node(anchorCam2)

func _physics_process(delta):
	if Input.is_action_just_pressed("R_Click") and !geralLerp:
		setCam = !setCam
	
	if !geralLerp:
		if setCam:
			global_transform.origin = lerp(global_transform.origin,anchorCam2.global_transform.origin,0.05)
			lookToPlayer = true
		else:
			global_transform.origin = lerp(global_transform.origin,anchorCam1.global_transform.origin,0.05)
			lookToPlayer = true
	else:
		global_transform.origin = lerp(global_transform.origin,anchorGeral.global_transform.origin,0.05)
	
	if lookToPlayer:
		look_at(get_parent().global_transform.origin,Vector3.UP)

#func _on_Area_body_entered(body):
#	if body.is_in_group("Player"):
#		get_tree().get_nodes_in_group("Pointer")[0].camera = get_node(cam2)
#		get_node(cam1).current = false
#		get_node(cam2).current = true
#
#func _on_Area2_body_entered(body):
#	if body.is_in_group("Player"):
#		get_tree().get_nodes_in_group("Pointer")[0].camera = get_node(cam1)
#		get_node(cam1).current = true
#		get_node(cam2).current = false
