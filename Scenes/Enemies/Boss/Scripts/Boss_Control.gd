extends KinematicBody

onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var pointer = get_tree().get_nodes_in_group("Pointer")[0]
onready var cineCamera = get_tree().get_nodes_in_group("CineCamera")[0]
var clicked = false
var hasStarted = false
export var getCineCam = false

func _ready():
	if getCineCam:
		cineCamera.connect("camera_activated",self,"cinematic_mode")
		
func _on_Boss_01_input_event(camera, event, position, normal, shape_idx):
	if Input.is_action_just_pressed("Click") and hasStarted:
		var playerBattle = player.get_node("States/Battling")
		playerBattle.show()
		playerBattle.scriptEnemy = self
		playerBattle.actualEnemy = self
		playerBattle.goFight = true
		playerBattle.releasePointer = true
		playerBattle.limitToAttackMelee = 3
		clicked = true
		
func _on_Boss_01_mouse_exited():
	clicked = false

func cinematic_mode(status):
	if status == "started":
		$States/Idle.show()
		$States/Move.hide()
		$States/Attack.hide()
		$Life3D.hide()
	else:
		$States/Idle.hide()
		$States/Move.show()
		$States/Attack.show()
		$Life3D.show()
		hasStarted = true
