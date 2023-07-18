extends CSGBox

export (NodePath) var camElevator
export (NodePath) var pointer
export (NodePath) var pointerPosInside
export (NodePath) var player
export (NodePath) var pointerPosOutside
export var sceneToGo = ""
export var side = ""

var goToElevator = false
var changeStage = false
var startStage = false
var selectedThis = false

func _ready():
	camElevator = get_node(camElevator)
	pointer = get_node(pointer)
	pointerPosInside = get_node(pointerPosInside)
	pointerPosOutside = get_node(pointerPosOutside)
	player = get_node(player)
	
	if side == StartLevelPos.whereToOut:
		startStage = true
		start_level()
	
func _physics_process(_delta):
	if goToElevator and selectedThis:
		var dist = player.global_transform.origin.distance_to(pointerPosInside.global_transform.origin)
		if dist < 0.5 and !changeStage and !startStage:
			$AnimationPlayer_Door.play("Close")
			changeStage = true
			yield(get_tree().create_timer(3),"timeout")
			get_tree().change_scene(sceneToGo)

func _on_Area_Elevator_mouse_entered():
	if !goToElevator: 
		$AnimationPlayer_Door.play("Open")
		
func _on_Area_Elevator_mouse_exited():
	if !goToElevator:
		$AnimationPlayer_Door.play("Close")
		
func _on_Area_Elevator_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_action_pressed("Click") and !goToElevator and !player.get_node("States/Battling").goFight:
			$AnimationPlayer_Door.play("Open")
			
			player.get_node("Inventory").hide()
			player.get_node("TabletInformation").hide()
			player.get_node("Life").hide()
			
			pointer.global_transform.origin = pointerPosInside.global_transform.origin
			pointer.camera.current = false
			camElevator.current = true
			pointer.isStopped = true
			selectedThis = true
			StartLevelPos.whereToOut = side
			goToElevator = true
			
func start_level():
	pointer.hide()
	pointer.global_transform.origin = pointerPosInside.global_transform.origin
	player.global_transform.origin = pointerPosInside.global_transform.origin
	
	player.get_node("States/Move").hide()
	player.get_node("States/Talking").show()
	player.get_node("Inventory").hide()
	player.get_node("TabletInformation").hide()
	player.get_node("Status").hide()
	owner.get_node("WhiteTransition/Back").hide()
	QuestManager.get_node("Buttons_Diary").hide()
	
	pointer.camera.current = false
	camElevator.current = true
	$AnimationPlayer_Door.play("Open")
	goToElevator = true
	
	yield(get_tree().create_timer(2),"timeout")
	
	pointer.global_transform.origin = pointerPosOutside.global_transform.origin
	pointer.camera.current = true
	camElevator.current = false
	
	player.get_node("States/Move").show()
	player.get_node("States/Talking").hide()
	
	yield(get_tree().create_timer(2),"timeout")
	
	$AnimationPlayer_Door.play("Close")
	
	player.get_node("Inventory").show()
	player.get_node("TabletInformation").show()
	player.get_node("Status").show()
	
	if QuestManager.isInQuest:
		owner.get_node("WhiteTransition/Back").show()
		QuestManager.get_node("Buttons_Diary").show()
		
	pointer.isStopped = false
	goToElevator = false
	startStage = false

