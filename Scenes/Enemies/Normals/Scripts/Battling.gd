extends Spatial

signal enemy_destroyed
var speed = 1
export var distanceToStop = 2
var stop = false
var backToPatrol = false
var progressiveDamageToPlayer = false
var coolDown = false
var holdCooldown = false
var clone
var myRepairObj
#var explosion = load("res://Effects/Toon Explosion/Explosion.tscn")
var hit = load("res://Scenes/Attacks/Hit/Hit.tscn")
var bigHit = load("res://Scenes/Attacks/Big Hit/Big Hit.tscn")
var dir
var vel
var distanceToPlayer

func _ready():
	if owner.enemyType == "Laser":
		owner.get_node("Enemy/Root_Enemies/Laser/Flash").hide()

func _physics_process(_delta):
	if is_visible_in_tree():
		start_battle()
	
	if progressiveDamageToPlayer:
		GlobalAdmLifeEnergy.life_changer(-owner.enemyResource.atkValue * _delta)

func start_battle():
	if !backToPatrol:
		if clone == null:
			distanceToPlayer = owner.get_node("Enemy").global_transform.origin.distance_to(owner.player.global_transform.origin) - 0.1
			owner.get_node("States/Move").target = owner.player
			owner.get_node("States/Move").show()
#			dir = owner.player.global_transform.origin - owner.get_node("Enemy").global_transform.origin
#			vel = dir * speed
#			owner.get_node("Enemy").look_at(owner.player.transform.origin,Vector3.UP)
		else:
			distanceToPlayer = owner.get_node("Enemy").global_transform.origin.distance_to(clone.global_transform.origin) - 0.5
			owner.get_node("States/Move").target = clone
			owner.get_node("States/Move").show()
#			dir = clone.global_transform.origin - owner.get_node("Enemy").global_transform.origin
#			vel = dir * speed 
#			owner.get_node("Enemy").look_at(clone.transform.origin,Vector3.UP)
		
		if distanceToPlayer <= distanceToStop:
			stop = true
			owner.get_node("States/Move").hide()
			var target_global_pos = owner.player.global_transform.origin
			var self_global_pos = owner.get_node("Enemy").global_transform.origin
			var look_at_position = Vector3(target_global_pos.x, self_global_pos.y, target_global_pos.z)
			owner.get_node("Enemy").look_at(look_at_position, Vector3.UP)
			
			if owner.enemyResource.haveCooldown:
				if !coolDown:
					if !holdCooldown:
						owner.get_node("CoolDown").start(owner.enemyResource.cooldown)
						holdCooldown = true
					owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayer").play("Attack")
				else:
					owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayer").play("Idle")
					if owner.enemyType == "Laser":
						owner.get_node("Enemy/Root_Enemies/Laser/Flash").hide()
						owner.get_node("Enemy/Root_Enemies/Laser/Laser").hide()
						set_collisor_status("Enemy/Root_Enemies/Laser/Laser/Area_Laser/CollisionShape",true)
			else:
				owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayer").play("Attack")
		else:
			owner.get_node("CoolDown").stop()
			owner.get_node("States/Move").show()
			coolDown = false
			holdCooldown = false
			stop = false
			owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayer").play("Idle")
		#---------------------------
#		owner.get_node("Enemy").move_and_slide(vel.normalized() * speed,Vector3.UP)
	else:
		var distanceToPatrol = owner.get_node("Enemy").global_transform.origin.distance_to(owner.get_node("LastPos").global_transform.origin)
		
		if distanceToPatrol <= 0.5:
			owner.disable_looking_collision()
			owner.get_node("States/Patrol").show()
			owner.get_node("States/Battling").hide()
			owner.get_node("States/Move").hide()
			owner.get_node("Enemy").rotation = Vector3.ZERO
			backToPatrol = true
		else:
			if owner.enemyType == "Laser":
				owner.get_node("Enemy/Root_Enemies/Laser/Anchor_Laser/Laser").hide()
				owner.get_node("Enemy/Root_Enemies/Laser/Anchor_Laser/Hitbox").hide()
			
			owner.get_node("States/Move").target = owner.get_node("LastPos")
			owner.get_node("States/Move").show()
			
#			dir = owner.get_node("LastPos").global_transform.origin - owner.get_node("Enemy").global_transform.origin
#			vel = dir * speed
#			owner.get_node("Enemy").look_at(owner.get_node("LastPos").global_transform.origin,Vector3.UP)
#			owner.get_node("Enemy").move_and_slide(vel.normalized() * speed,Vector3.UP)

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
		GlobalMusicPlayer.play_sound("play_one",owner.sfxResource.sfx["InimigoGeralMorre"])
		owner.player.get_node("States/Battling").actualEnemy = null
		owner.player.get_node("States/Battling").end_fight()
#		var spawnExplosion = explosion.instance()
#		owner.owner.add_child(spawnExplosion)
#		spawnExplosion.global_transform.origin = Vector3(owner.get_node("Enemy").global_transform.origin.x,spawnExplosion.global_transform.origin.y,owner.get_node("Enemy").global_transform.origin.z)
		if myRepairObj != null:
			myRepairObj.get_node("States/Healing").backToPatrol = true
		owner.queue_free()

func _on_Damage_Area_area_entered(area):
	if area.is_in_group("Melee"):
		if owner.player.selectedGun == owner.player.mainGun:
			owner.get_node("Viewport/BarLife").value -= GlobalValues.atkMainActual
		elif owner.player.selectedGun == owner.player.secGun:
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
		GlobalMusicPlayer.play_sound("play_one",owner.sfxResource.sfx["InimigoGeralDano"])
	elif area.is_in_group("Projectile"):
		if owner.player.selectedGun == owner.player.mainGun:
			owner.get_node("Viewport/BarLife").value -= GlobalValues.atkMainActual
		elif owner.player.selectedGun == owner.player.secGun:
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
		owner.back_to_patrol()
		area.queue_free()
		GlobalMusicPlayer.play_sound("play_one",owner.sfxResource.sfx["InimigoGeralDano"])
func set_collisor_status(path,status):
	owner.get_node(path).set_deferred("disabled",status)

func _on_Area_Laser_area_entered(area):
	if area.is_in_group("DamagePlayer"):
		progressiveDamageToPlayer = true
		
func _on_Area_Laser_area_exited(area):
	if area.is_in_group("DamagePlayer"):
		progressiveDamageToPlayer = false
		set_collisor_status("Enemy/Root_Enemies/Laser/Anchor_Laser/Area_Laser/CollisionShape",true)
		
func _on_Attack_Area_entered(area):
	if area.is_in_group("DamagePlayer"):
		GlobalAdmLifeEnergy.life_changer(-owner.enemyResource.atkValue)

func _on_CoolDown_timeout():
	coolDown = !coolDown
	holdCooldown = false

