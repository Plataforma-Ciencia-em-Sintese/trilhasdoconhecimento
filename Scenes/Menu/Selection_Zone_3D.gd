extends Spatial

export var offsetLook = 1.0
var target = ["Floor/Ariel","Floor/Bento","Floor/Clara","Floor/Caio","Floor/Yara"]
var id = 0
var canChange = true
var atributos

func _ready():
	pass

func _physics_process(delta):
#	$Cam_Pivot.look_at(get_node(target[id]).global_transform.origin,Vector3.UP)
	$Cam_Pivot.rotation.y = (lerp_angle($Cam_Pivot.rotation.y, get_node(target[id]).rotation.y + offsetLook,0.2))
	
	if id == 0:
		offsetLook = 1.85
	elif id == 1:
		offsetLook = 1.98
	elif id == 2:
		offsetLook = 1.8
	elif id == 3:
		offsetLook = 1.9
	elif id == 4:
		offsetLook = 2.02
	
	_area_attributes()

#func _on_Area_mouse_entered(charName,selectedId):
#	if selectedId == id:
#		canChange = false
#		get_node("Floor").get_node(charName).get_node("Virtual").show()
#		get_node("Floor").get_node(charName).get_node("Padrao").hide()
	
#func _on_Area_mouse_exited(charName,selectedId):
#	if selectedId == id:
#		canChange = true
#		get_node("Floor").get_node(charName).get_node("Padrao").show()
#		get_node("Floor").get_node(charName).get_node("Virtual").hide()

func _area_attributes():
	if id == 0:
		$ControlButtons/Panel_Bento.show()
		$ControlButtons/Panel_Clara.hide()
		$ControlButtons/Panel_Caio.hide()
		$ControlButtons/Panel_Yara.hide()
		$ControlButtons/Panel_Ariel.hide()
	elif id == 1:
		$ControlButtons/Panel_Bento.hide()
		$ControlButtons/Panel_Clara.show()
		$ControlButtons/Panel_Caio.hide()
		$ControlButtons/Panel_Yara.hide()
		$ControlButtons/Panel_Ariel.hide()
	elif id == 2:
		$ControlButtons/Panel_Bento.hide()
		$ControlButtons/Panel_Clara.hide()
		$ControlButtons/Panel_Caio.show()
		$ControlButtons/Panel_Yara.hide()
		$ControlButtons/Panel_Ariel.hide()
	elif id == 3:
		$ControlButtons/Panel_Bento.hide()
		$ControlButtons/Panel_Clara.hide()
		$ControlButtons/Panel_Caio.hide()
		$ControlButtons/Panel_Yara.show()
		$ControlButtons/Panel_Ariel.hide()
	elif id == 4:
		$ControlButtons/Panel_Bento.hide()
		$ControlButtons/Panel_Clara.hide()
		$ControlButtons/Panel_Caio.hide()
		$ControlButtons/Panel_Yara.hide()
		$ControlButtons/Panel_Ariel.show()

func _on_ButtonPlay_pressed():
	if id == 0:
		get_node("Floor").get_node("Bento").get_node("Virtual").show()
		get_node("Floor").get_node("Bento").get_node("Padrao").hide()
		GlobalValues.nameChar = "Bento"
		GlobalValues.skinChar = "Normal"
		yield(get_tree().create_timer(3),"timeout")
		var _play: bool = get_tree().change_scene("res://Scenes/Sci Fi Room/New_Debug_Room_2.tscn")
	if id == 1:
		GlobalValues.nameChar = "Clara"
		GlobalValues.skinChar = "Normal"
		var _play: bool = get_tree().change_scene("res://Scenes/Sci Fi Room/New_Debug_Room_2.tscn")
	if id == 2:
		GlobalValues.nameChar = "Caio"
		GlobalValues.skinChar = "Normal"
		var _play: bool = get_tree().change_scene("res://Scenes/Sci Fi Room/New_Debug_Room_2.tscn")
	if id == 3:
		GlobalValues.nameChar = "Yara"
		GlobalValues.skinChar = "Normal"
		var _play: bool = get_tree().change_scene("res://Scenes/Sci Fi Room/New_Debug_Room_2.tscn")
	if id == 4:
		GlobalValues.nameChar = "Ariel"
		GlobalValues.skinChar = "Normal"
		var _play: bool = get_tree().change_scene("res://Scenes/Sci Fi Room/New_Debug_Room_2.tscn")

func _on_ButtonLeft_pressed():
	if canChange:
		if id > 0:
			id -= 1
		else:
			id = 4

func _on_ButtonRight_pressed():
	if canChange:
		if id < target.size() - 1:
			id += 1
		else:
			id = 0

