extends Spatial

export (String,"Projectile","Melee") var attackType
export var limitToAttackMelee = 1.5
export var limitToAttackBullet = 5
var goFight = false
var releasePointer = true
var actualEnemy
var scriptEnemy
var energyBall = load("res://Scenes/Attacks/Projectiles/Energy_Ball.tscn")
var arrowDrill = load("res://Scenes/Attacks/Projectiles/Arrow_Drill.tscn")
var impactBoom = load("res://Scenes/Attacks/Projectiles/ImpactBoom.tscn")
onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var pointer = get_tree().get_nodes_in_group("Pointer")[0]
onready var animator = owner.get_node("AnimationTree")

func _physics_process(_delta):
	if goFight:
		start_fight()

func start_fight():
	var dist = owner.global_transform.origin.distance_to(actualEnemy.global_transform.origin)
	if releasePointer:
		pointer.global_transform.origin = actualEnemy.global_transform.origin
		pointer.hide()
		owner.get_node("Inventory").hide()
		animator.set("parameters/States General/blend_amount",1)
		
		if player.selectedGun == "Escudo":
			animator["parameters/All_Attacks/current"] = 0
			attackType = "Melee"
			
		elif player.selectedGun == "Espada":
			animator["parameters/All_Attacks/current"] = 1
			attackType = "Melee"
			
		elif player.selectedGun == "Varinha":
			animator["parameters/All_Attacks/current"] = 2
			attackType = "Projectile"
			
		elif player.selectedGun == "Manopla":
			animator["parameters/All_Attacks/current"] = 3
			attackType = "Projectile"
			
		elif player.selectedGun == "Arco":
			animator["parameters/All_Attacks/current"] = 4
			attackType = "Projectile"
	
		if attackType == "Melee":
			if dist <= limitToAttackMelee:
				animator.set("parameters/move/blend_amount",0)
				owner.get_node("States/Move").hide()
				owner.get_node("Battle_UI/Main_Container").hide()
				owner.get_node("Battle_UI/Sec_Container").hide()
				releasePointer = false
		else:
			if dist <= limitToAttackBullet:
				animator.set("parameters/move/blend_amount",0)
				owner.get_node("States/Move").hide()
				owner.get_node("Battle_UI/Main_Container").hide()
				owner.get_node("Battle_UI/Sec_Container").hide()
				releasePointer = false
			
#			if owner.mainChar == "Caio":
#				owner.get_node("Base/Skeleton/BoneAttachmentR/Sword/ProtonTrail").emit = true
		
		owner.get_node("Base/Skeleton").rotation_degrees.y = 180
		var target_global_pos = actualEnemy.global_transform.origin
		var self_global_pos = owner.global_transform.origin
		var look_at_position = Vector3(target_global_pos.x, self_global_pos.y, target_global_pos.z)
		owner.get_node("Base").look_at(look_at_position, Vector3.UP)
		
	if Input.is_action_just_pressed("Click") and !scriptEnemy.clicked and pointer.outInterface:
		end_fight()
		yield(get_tree().create_timer(1),"timeout")
		if goFight:
			releasePointer = true

func end_fight():
	owner.get_node("Battle_UI/Main_Container").show()
	owner.get_node("Battle_UI/Sec_Container").show()
	pointer.show()
	animator.set("parameters/States General/blend_amount",0)
	animator.set("parameters/Seek/seek_position",0)
	owner.get_node("Base/Skeleton").rotation_degrees.y = 0
	owner.get_node("States/Move").show()
	owner.get_node("Inventory").show()
	releasePointer = false
	goFight = false

func set_melee_hitbox(disabled,path):
	owner.get_node(path).set_deferred("disabled",disabled)

func spawn_bullet(type):
	if type == "Energy Ball":
		var bullet = energyBall.instance()
		owner.owner.add_child(bullet)
		bullet.global_transform = player.get_node("Base/Skeleton/BoneAttachmentR/Wand/Spawner").global_transform
	elif type == "Arrow":
		var bullet = arrowDrill.instance()
		owner.owner.add_child(bullet)
		bullet.global_transform = player.get_node("Base/Skeleton/BoneAttachmentR/Bow/Spawner").global_transform
	elif type == "Boom":
		var bullet = impactBoom.instance()
		owner.owner.add_child(bullet)
		bullet.global_transform = player.get_node("Base/Skeleton/BoneAttachmentR/Boom_Spawner").global_transform

func _on_Damage_Zone_area_entered(area):
	if area.is_in_group("Enemy_Area") and !goFight:
		actualEnemy = area
		scriptEnemy = area.owner
		goFight = true
		releasePointer = true

func _on_Damage_Zone_area_exited(area):
	if area.is_in_group("Enemy_Area"):
		area = null
#		if owner.mainChar == "Caio": 
#			owner.get_node("Base/Skeleton/BoneAttachmentR/Sword/ProtonTrail").emit = false
