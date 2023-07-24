extends Spatial

var speed = 1
export var damageSword = 20
export var damageHammer = 20
export var damageEnergyBall = 20
export var distanceToStop = 2
var stop = false
var backToPatrol = false
var progressiveDamageToPlayer = false
var player
var clone
var myRepairObj
#var explosion = load("res://Effects/Toon Explosion/Explosion.tscn")
var hit = load("res://Scenes/Attacks/Hit/Hit.tscn")
var bigHit = load("res://Scenes/Attacks/Big Hit/Big Hit.tscn")
var dir
var vel

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	if owner.enemyType == "Laser":
		owner.get_node("Enemy/Root_Enemies/Laser/Flash").hide()

func _physics_process(_delta):
	if is_visible_in_tree():
		start_battle()
	
	if progressiveDamageToPlayer:
		player.get_node("Status").set_life(-2 * _delta)

func start_battle():
	if !backToPatrol:
		var distanceToPlayer
		if clone == null:
			distanceToPlayer = owner.get_node("Enemy").global_transform.origin.distance_to(player.global_transform.origin) - 0.1
			dir = player.global_transform.origin - owner.get_node("Enemy").global_transform.origin
			vel = dir * speed
			owner.get_node("Enemy").look_at(player.transform.origin,Vector3.UP)
		else:
			distanceToPlayer = owner.get_node("Enemy").global_transform.origin.distance_to(clone.global_transform.origin) - 0.5
			dir = clone.global_transform.origin - owner.get_node("Enemy").global_transform.origin
			vel = dir * speed 
			owner.get_node("Enemy").look_at(clone.transform.origin,Vector3.UP)
		
		if distanceToPlayer <= distanceToStop:
			stop = true
			owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayer").play("Attack")
		else:
			stop = false
			owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayer").play("Idle")
		#---------------------------	
		owner.get_node("Enemy").move_and_slide(vel.normalized() * speed,Vector3.UP)
	else:
		var distanceToPatrol = owner.get_node("Enemy").global_transform.origin.distance_to(owner.get_node("LastPos").global_transform.origin) - 0.1
		
		if distanceToPatrol <= 0.1:
			owner.disable_looking_collision()
			owner.get_node("States/Patrol").show()
			owner.get_node("States/Battling").hide()
			self.hide()
			backToPatrol = true
		else:
			if owner.enemyType == "Laser":
				owner.get_node("Enemy/Root_Enemies/Laser/Laser").hide()
				owner.get_node("Enemy/Root_Enemies/Laser/Flash").hide()
			dir = owner.get_node("LastPos").global_transform.origin - owner.get_node("Enemy").global_transform.origin
			vel = dir * speed
			owner.get_node("Enemy").look_at(owner.get_node("LastPos").global_transform.origin,Vector3.UP)
			owner.get_node("Enemy").move_and_slide(vel.normalized() * speed,Vector3.UP)

func check_life():
	var getRepair = get_tree().get_nodes_in_group("RootEnemy")
	if owner.get_node("Viewport/BarLife").value <= 20 and owner.enemyType != "Reparador":
		for i in getRepair.size():
			if getRepair[i].enemyType == "Reparador":
				getRepair[i].get_node("States/Healing").backToPatrol = false
				getRepair[i].get_node("States/Healing").ally = owner.get_node("Enemy")
				getRepair[i].get_node("States/Healing").allyBarLife = owner.get_node("Viewport/BarLife")
				getRepair[i].get_node("States/Healing").show()
				getRepair[i].get_node("States/Patrol").hide()
				myRepairObj = getRepair[i]
				break
	if owner.get_node("Viewport/BarLife").value <= 0:
		player.get_node("States/Battling").actualEnemy = null
		player.get_node("States/Battling").end_fight()
#		var spawnExplosion = explosion.instance()
#		owner.owner.add_child(spawnExplosion)
#		spawnExplosion.global_transform.origin = Vector3(owner.get_node("Enemy").global_transform.origin.x,spawnExplosion.global_transform.origin.y,owner.get_node("Enemy").global_transform.origin.z)
		if myRepairObj != null:
			myRepairObj.get_node("States/Healing").backToPatrol = true
		owner.queue_free()

func _on_Damage_Area_area_entered(area):
	if area.is_in_group("Melee"):
		if player.selectedGun == player.mainGun:
			owner.get_node("Viewport/BarLife").value -= GlobalValues.atkMainActual
		elif player.selectedGun == player.secGun:
			owner.get_node("Viewport/BarLife").value -= GlobalValues.atkSecActual
		
		owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayerHit").play("Hit")
		var spawnHit = hit.instance()
		owner.owner.add_child(spawnHit)
		spawnHit.global_transform = owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("Melee_Hit").global_transform
		
		if owner.enemyType != "Reparador":
			owner.get_node("Wait_to_Back").stop()
			owner.get_node("States/Battling").backToPatrol = false
			owner.get_node("States/Battling").show()
			owner.get_node("States/Patrol").hide()
		owner.get_node("Enemy/Looking_Zone/Zone").get_surface_material(0).albedo_color = Color(1, 0, 0, 0.05)
		check_life()
		
	if area.is_in_group("Bullet"):
		if player.selectedGun == player.mainGun:
			owner.get_node("Viewport/BarLife").value -= GlobalValues.atkMainActual
		elif player.selectedGun == player.secGun:
			owner.get_node("Viewport/BarLife").value -= GlobalValues.atkSecActual
		
		owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayerHit").play("Hit")
		var spawnHit = hit.instance()
		owner.owner.add_child(spawnHit)
		spawnHit.global_transform = owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("Melee_Hit").global_transform
		
		if owner.enemyType != "Reparador":
			owner.get_node("Wait_to_Back").stop()
			owner.get_node("States/Battling").backToPatrol = false
			owner.get_node("States/Battling").show()
			owner.get_node("States/Patrol").hide()
		owner.get_node("Enemy/Looking_Zone/Zone").get_surface_material(0).albedo_color = Color(1, 0, 0, 0.05)
		area.queue_free()
		check_life()
		
#	if area.is_in_group("Sword"):
#		owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayerHit").play("Hit")
#		var spawnHit = hit.instance()
#		owner.owner.add_child(spawnHit)
#		spawnHit.global_transform = owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("Melee_Hit").global_transform
#		check_life()
#
#	if area.is_in_group("Hammer"):
#		owner.get_node("Viewport/BarLife").value -= damageHammer
#		owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayerHit").play("Hit")
#		var spawnHit = bigHit.instance()
#		owner.owner.add_child(spawnHit)
#		spawnHit.global_transform = owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("Melee_Hit").global_transform
#		check_life()
#
#	if area.is_in_group("EnergyBall"):
#		owner.get_node("Viewport/BarLife").value -= damageEnergyBall
#		owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayerHit").play("Hit")
#
#		var spawnHit = bigHit.instance()
#		owner.owner.add_child(spawnHit)
#		spawnHit.global_transform = owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("Melee_Hit").global_transform
#
#		if owner.enemyType != "Reparador":
#			owner.get_node("Wait_to_Back").stop()
#			owner.get_node("States/Battling").backToPatrol = false
#			owner.get_node("States/Battling").show()
#			owner.get_node("States/Patrol").hide()
#			owner.get_node("Enemy/Looking_Zone/Zone").get_surface_material(0).albedo_color = Color(1, 0, 0, 0.05)
#			area.queue_free()
#			check_life()

func set_collisor_status(path,status):
	owner.get_node(path).set_deferred("disabled",status)

func _on_Area_Laser_area_entered(area):
	if area.is_in_group("DamagePlayer"):
		progressiveDamageToPlayer = true
		
func _on_Area_Laser_area_exited(area):
	if area.is_in_group("DamagePlayer"):
		progressiveDamageToPlayer = false
		set_collisor_status("Enemy/Root_Enemies/Laser/Laser/Area_Laser/CollisionShape",true)
		
func _on_Attack_Area_Parafuso_area_entered(area):
	if area.is_in_group("DamagePlayer"):
		player.get_node("Status").set_life(-3)
		print("player na area parafuso")
