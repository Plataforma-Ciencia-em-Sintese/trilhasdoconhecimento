extends PathFollow

export (String, "Furadeiro", "Laser", "Destruidor", "Reparador") var enemyType

var enemyResource
var clicked = false
onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	get_enemy(enemyType)
	enemyResource = load("res://Scenes/Enemies/Normals/Resource Enemy/" + enemyType + ".tres")
	$Viewport/BarLife.max_value = enemyResource.life
	$Viewport/BarLife.value = enemyResource.life
	$States/Patrol.speed = enemyResource.speed
	$States/Battling.speed = enemyResource.speed
	$States/Healing.speed = enemyResource.speed
	$States/Move.speed = enemyResource.speed
	$States/Battling.distanceToStop = enemyResource.distanceToStop
	
	$Enemy/Looking_Zone/CollisionShape.shape.radius = enemyResource.lookingArea
	$Enemy/Looking_Zone/Zone.scale = Vector3(enemyResource.lookingArea,0,enemyResource.lookingArea)
	
	if enemyType == "Furadeiro":
		$Enemy/Root_Enemies/Furadeiro/IA_01/Attack_Area_Parafuso/CollisionShape.shape.radius = enemyResource.hitboxSize
		$Enemy/Hitbox.scale = Vector3(enemyResource.hitboxSize,enemyResource.hitboxSize,enemyResource.hitboxSize)
	elif enemyType == "Laser":
		$Enemy/Root_Enemies/Laser/Laser/Area_Laser/CollisionShape.shape.height = enemyResource.hitboxSize
		$Enemy/Laser_Hitbox.scale = Vector3($Enemy/Laser_Hitbox.scale.x,enemyResource.hitboxSize,$Enemy/Laser_Hitbox.scale.z)
	elif enemyType == "Destruidor":
		$Enemy/Root_Enemies/Destruidor/Attack_Area_Destruidor/CollisionShape.shape.radius = enemyResource.hitboxSize
		$Enemy/Root_Enemies/Destruidor/Attack_Area_Destruidor/Hitbox.scale = Vector3(enemyResource.hitboxSize,enemyResource.hitboxSize,enemyResource.hitboxSize)
		if enemyResource.showHitbox:
			$Enemy/Root_Enemies/Destruidor/Attack_Area_Destruidor/Hitbox.show()
		else:
			$Enemy/Root_Enemies/Destruidor/Attack_Area_Destruidor/Hitbox.hide()
		
#	if enemyResource.showPatrolArea:
#		$Enemy/Looking_Zone/Zone.show()
#	else:
#		$Enemy/Looking_Zone/Zone.hide()
#
#	if enemyResource.showHitbox:
#		if enemyType != "Laser":
#			$Enemy/Hitbox.show()
#			$Enemy/Laser_Hitbox.hide()
#		else:
#			$Enemy/Hitbox.hide()
#			$Enemy/Laser_Hitbox.show()
#	else:
#		$Enemy/Hitbox.hide()
#		$Enemy/Laser_Hitbox.hide()
	
	$States/Patrol.show()
	$States/Move.hide()
	$States/Battling.hide()
	$States/Healing.hide()
		
func get_enemy(type):
	for i in $Enemy/Root_Enemies.get_children():
		if i.name != type:
			i.queue_free()
			
func _on_Looking_Zone_body_entered(body):
	if enemyType != "Reparador":
		if body.is_in_group("Player") or body.is_in_group("Clone"):
			$Wait_to_Back.stop()
			$States/Battling.backToPatrol = false
			$States/Battling.show()
			$States/Patrol.hide()
			$Enemy/Looking_Zone/Zone.get_surface_material(0).albedo_color = Color(1, 0, 0, 0.05)

func _on_Looking_Zone_body_exited(body):
	if body.is_in_group("Player") and $Viewport/BarLife.value > 0:
		back_to_patrol()

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

func back_to_patrol():
	$Wait_to_Back.start(enemyResource.timeToPursuitPlayer)
	$Enemy/Looking_Zone/Zone.get_surface_material(0).albedo_color = Color( 0.956863, 0.643137, 0.376471, 0.05)
