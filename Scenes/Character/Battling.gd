extends Spatial

export (String,"Projectile","Melee") var attackType
var animator
var goFight = false
var releasePointer = true
var actualEnemy
var scriptEnemy
var pointer
var energyBall = load("res://Scenes/Attacks/Projectiles/Energy_Ball.tscn")
var arrowDrill = load("res://Scenes/Attacks/Projectiles/Arrow_Drill.tscn")
var impactBoom = load("res://Scenes/Attacks/Projectiles/ImpactBoom.tscn")
onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	animator = owner.get_node("AnimationTree")
	pointer = get_tree().get_nodes_in_group("Pointer")[0]

func _physics_process(delta):
	if goFight:
		start_fight()

func start_fight():
	var dist = owner.global_transform.origin.distance_to(actualEnemy.global_transform.origin)
	
	if releasePointer:
		pointer.global_transform.origin = actualEnemy.global_transform.origin
		pointer.hide()
		owner.get_node("Inventory").hide()
		animator.set("parameters/States General/blend_amount",1)
		
		if owner.mainGun == "Escudo":
			animator["parameters/All_Attacks/current"] = 0
			attackType = "Melee"
			
		elif owner.mainGun == "Espada":
			animator["parameters/All_Attacks/current"] = 1
			attackType = "Melee"
			
		elif owner.mainGun == "Varinha":
			animator["parameters/All_Attacks/current"] = 2
			attackType = "Projectile"
			
		elif owner.mainGun == "Manopla":
			animator["parameters/All_Attacks/current"] = 3
			attackType = "Projectile"
			
		elif owner.mainGun == "Arco":
			animator["parameters/All_Attacks/current"] = 4
			attackType = "Projectile"
	
		if attackType == "Melee":
			print(dist)
			if dist <= 1.5:
				owner.get_node("Base/Skeleton").rotation_degrees.y = 180
				owner.get_node("Base").look_at(actualEnemy.global_transform.origin,Vector3.UP)
				animator.set("parameters/move/blend_amount",0)
				owner.get_node("States/Move").hide()
				releasePointer = false
		else:
			if dist <= 5:
				owner.get_node("Base").look_at(actualEnemy.global_transform.origin,Vector3.UP)
				owner.get_node("Base/Skeleton").rotation_degrees.y = 180
				animator.set("parameters/move/blend_amount",0)
				owner.get_node("States/Move").hide()
				releasePointer = false
			
			if owner.mainChar == "Caio":
				owner.get_node("Base/Skeleton/BoneAttachmentR/Sword/ProtonTrail").emit = true

	if Input.is_action_just_pressed("Click") and !scriptEnemy.clicked and pointer.outInterface:
		end_fight()
		yield(get_tree().create_timer(1),"timeout")
		if goFight:
			releasePointer = true

func end_fight():
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
		bullet.dir = bullet.global_transform.basis.x
	elif type == "Arrow":
		var bullet = arrowDrill.instance()
		owner.owner.add_child(bullet)
		bullet.global_transform = player.get_node("Base/Skeleton/BoneAttachmentR/Bow/Spawner").global_transform
		bullet.dir = bullet.global_transform.basis.x
	elif type == "Boom":
		var bullet = impactBoom.instance()
		owner.owner.add_child(bullet)
		bullet.global_transform = player.get_node("Base/Skeleton/BoneAttachmentR/Boom_Spawner").global_transform
		bullet.dir = bullet.global_transform.basis.x

func _on_Damage_Zone_area_entered(area):
	if area.is_in_group("Enemy_Area") and !goFight:
		actualEnemy = area
		scriptEnemy = area.owner
		goFight = true
		releasePointer = true

func _on_Damage_Zone_area_exited(area):
	if area.is_in_group("Enemy_Area"):
		area = null
		goFight = false
		end_fight()
		if owner.mainChar == "Caio": 
			owner.get_node("Base/Skeleton/BoneAttachmentR/Sword/ProtonTrail").emit = false
