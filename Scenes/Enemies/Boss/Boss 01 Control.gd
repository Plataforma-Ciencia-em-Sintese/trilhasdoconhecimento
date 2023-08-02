extends KinematicBody

onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var pointer = get_tree().get_nodes_in_group("Pointer")[0]
var clicked = false

func _on_Boss_01_input_event(camera, event, position, normal, shape_idx):
	if Input.is_action_just_pressed("Click"):
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
