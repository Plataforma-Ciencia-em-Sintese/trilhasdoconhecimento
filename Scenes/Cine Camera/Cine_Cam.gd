extends Camera

export (String, "Automatic","Trigger") var camMovement
export (Dictionary) var infos
export (bool) var deactivated = false
var targetToLook
var posToLook
var actualPos = 0
onready var descriptionTxt = $CanvasLayer/BG_Text/Desc
onready var cameraMain = get_tree().get_nodes_in_group("Camera")[0]
signal camera_activated(status)

func _ready():
	if !deactivated:
		emit_signal("camera_activated","started")
		$CanvasLayer.show()
		cameraMain.current = false
		current = true
		targetToLook = get_node(infos[actualPos][0])
		posToLook = get_node(infos[actualPos][1])
		descriptionTxt.text = infos[actualPos][5]
		
		if camMovement == "Automatic":
			$Timer.start(infos[actualPos][2])
			$CanvasLayer/BG_Text/BTN_Continue.hide()
		else:
			$CanvasLayer/BG_Text/BTN_Continue.show()
	else:
		$CanvasLayer.hide()
		cameraMain.current = true
		current = false

func _physics_process(delta):
	if !deactivated:
		cine_camera(targetToLook,posToLook)

func cine_camera(target,pos):
#	rotation.y = lerp_angle(rotation.y,atan2(-target.global_transform.origin.x,-target.global_transform.origin.z),0.01)
	var look = global_transform.looking_at(target.global_transform.origin,Vector3.UP)
	var rot = look.basis
	global_transform.basis = global_transform.basis.slerp(rot,infos[actualPos][4])
	
	translation = lerp(global_transform.origin,pos.global_transform.origin,infos[actualPos][3])

func _on_Timer_timeout():
	if actualPos < infos.size()-1:
		actualPos += 1
		$Timer.start(infos[actualPos][2])
		if infos[actualPos][0] != "":
			targetToLook = get_node(infos[actualPos][0])
		if infos[actualPos][1] != "":
			posToLook = get_node(infos[actualPos][1])
		if infos[actualPos][5] != "":
			descriptionTxt.text = infos[actualPos][5]
	else:
		emit_signal("camera_activated","ended")
		cameraMain.current = true
		queue_free()
			
func _on_BTN_Continue_pressed():
	if actualPos < infos.size()-1:
		actualPos += 1
		if infos[actualPos][0] != "":
			targetToLook = get_node(infos[actualPos][0])
		if infos[actualPos][1] != "":
			posToLook = get_node(infos[actualPos][1])
		if infos[actualPos][5] != "":
			descriptionTxt.text = infos[actualPos][5]
	else:
		emit_signal("camera_activated","ended")
		cameraMain.current = true
		queue_free()
