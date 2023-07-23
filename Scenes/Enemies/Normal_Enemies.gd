extends PathFollow

export (String, "Furadeiro", "Laser", "Destruidor", "Reparador", "Bala") var enemyType
onready var player = get_tree().get_nodes_in_group("Player")[0]
var clicked = false

func _ready():
	get_enemy(enemyType)
	if enemyType == "Furadeiro":
		$Viewport/BarLife.max_value = 30
		$States/Patrol.speed = 2
		$States/Battling.speed = 2
	elif enemyType == "Laser":
		$Viewport/BarLife.max_value = 24
		$States/Patrol.speed = 2
		$States/Battling.speed = 2
	elif enemyType == "Destruidor":
		$Viewport/BarLife.max_value = 40
		$States/Patrol.speed = 3
		$States/Battling.speed = 3
	elif enemyType == "Reparador":
		$Viewport/BarLife.max_value = 26
		$States/Patrol.speed = 4
		$States/Battling.speed = 4
	elif enemyType == "Bala":
		$Viewport/BarLife.max_value = 14
		$States/Patrol.speed = 5
		$States/Battling.speed = 5
	
func get_enemy(type):
	for i in $Enemy/Root_Enemies.get_children():
		if i.name != type:
			i.queue_free()
			
func _on_Looking_Zone_body_entered(body):
	if body.is_in_group("Player") or body.is_in_group("Clone"):
		$Wait_to_Back.stop()
		$States/Battling.backToPatrol = false
		$States/Battling.show()
		$States/Patrol.hide()
		$Enemy/Looking_Zone/Zone.get_surface_material(0).albedo_color = Color(1, 0, 0, 0.05)

func _on_Looking_Zone_body_exited(body):
	if body.is_in_group("Player") and $Viewport/BarLife.value > 0:
		$Wait_to_Back.start(3)
		$Enemy/Looking_Zone/Zone.get_surface_material(0).albedo_color = Color( 0.956863, 0.643137, 0.376471, 0.05)

func disable_looking_collision():
	$Enemy/Looking_Zone/CollisionShape.set_deferred("disabled",true)
	yield(get_tree().create_timer(2),"timeout")
	$Enemy/Looking_Zone/CollisionShape.set_deferred("disabled",false)

func _on_Looking_Zone_input_event(_camera, _event, _position, _normal, _shape_idx):
	if Input.is_action_just_pressed("Click"):
		var playerBattle = player.get_node("States/Battling")
		playerBattle.show()
		playerBattle.scriptEnemy = self
		playerBattle.actualEnemy = $Enemy/Looking_Zone
		playerBattle.goFight = true
		playerBattle.releasePointer = true
		clicked = true

func _on_Looking_Zone_mouse_exited():
	clicked = false

func _on_Wait_to_Back_timeout():
	$States/Battling.backToPatrol = true
	$Enemy/Looking_Zone/Zone.get_surface_material(0).albedo_color = Color(0, 1, 0, 0.01)

