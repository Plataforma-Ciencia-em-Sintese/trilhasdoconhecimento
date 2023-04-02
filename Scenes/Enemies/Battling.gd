extends Spatial

export var speed = 1
export var damageSword = 20
export var damageHammer = 20
export var damageEnergyBall = 20
export var distanceToStop = 2
var stop = false
var backToPatrol = false
var player
var clone
var getOwner
var explosion = load("res://Effects/Toon Explosion/Explosion.tscn")
var hit = load("res://Scenes/Attacks/Hit/Hit.tscn")
var bigHit = load("res://Scenes/Attacks/Big Hit/Big Hit.tscn")
var dir
var vel

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	getOwner = owner

func _physics_process(_delta):
	if is_visible_in_tree():
		start_battle()

func start_battle():
	if !backToPatrol:
		var distanceToPlayer
		if clone == null:
			print("tem clone")
			distanceToPlayer = getOwner.get_node("Enemy").global_transform.origin.distance_to(player.global_transform.origin) - 0.1
			dir = player.global_transform.origin - getOwner.get_node("Enemy").global_transform.origin
			vel = dir * speed
			getOwner.get_node("Enemy").look_at(player.transform.origin,Vector3.UP)
		else:
			distanceToPlayer = getOwner.get_node("Enemy").global_transform.origin.distance_to(clone.global_transform.origin) - 0.5
			dir = clone.global_transform.origin - getOwner.get_node("Enemy").global_transform.origin
			vel = dir * speed
			getOwner.get_node("Enemy").look_at(clone.transform.origin,Vector3.UP)
		
		if distanceToPlayer <= distanceToStop:
			stop = true
			getOwner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayer").play("Attack")
		else:
			stop = false
			getOwner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayer").play("Idle")
		#---------------------------	
		getOwner.get_node("Enemy").move_and_slide(vel.normalized(),Vector3.UP)
	else:
		var distanceToPatrol = getOwner.get_node("Enemy").global_transform.origin.distance_to(getOwner.get_node("LastPos").global_transform.origin) - 0.1
		
		if distanceToPatrol <= 0.1:
			getOwner.disable_looking_collision()
			getOwner.get_node("States/Patrol").show()
			getOwner.get_node("States/Battling").hide()
			self.hide()
			backToPatrol = true
		else:
			var dir = getOwner.get_node("LastPos").global_transform.origin - getOwner.get_node("Enemy").global_transform.origin
			var vel = dir * speed
			getOwner.get_node("Enemy").look_at(getOwner.get_node("LastPos").global_transform.origin,Vector3.UP)
			getOwner.get_node("Enemy").move_and_slide(vel.normalized(),Vector3.UP)

func check_life():
	if getOwner.get_node("Viewport/BarLife").value <= 0:
		player.get_node("States/Battling").actualEnemy = null
		player.get_node("States/Battling").end_fight()
		var spawnExplosion = explosion.instance()
		owner.owner.add_child(spawnExplosion)
		spawnExplosion.global_transform.origin = Vector3(owner.get_node("Enemy").global_transform.origin.x,spawnExplosion.global_transform.origin.y,owner.get_node("Enemy").global_transform.origin.z)
		owner.queue_free()

func _on_Damage_Area_area_entered(area):
	if area.is_in_group("Sword"):
		getOwner.get_node("Viewport/BarLife").value -= damageSword
		getOwner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayerHit").play("Hit")
		var spawnHit = hit.instance()
		owner.owner.add_child(spawnHit)
		spawnHit.global_transform = owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("Melee_Hit").global_transform
		check_life()
	
	if area.is_in_group("Hammer"):
		getOwner.get_node("Viewport/BarLife").value -= damageHammer
		getOwner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayerHit").play("Hit")
		var spawnHit = bigHit.instance()
		owner.owner.add_child(spawnHit)
		spawnHit.global_transform = owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("Melee_Hit").global_transform
		check_life()
	
	if area.is_in_group("EnergyBall"):
		getOwner.get_node("Viewport/BarLife").value -= damageEnergyBall
		getOwner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayerHit").play("Hit")
		
		var spawnHit = bigHit.instance()
		owner.owner.add_child(spawnHit)
		spawnHit.global_transform = owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("Melee_Hit").global_transform
		
		getOwner.get_node("Wait_to_Back").stop()
		getOwner.get_node("States/Battling").backToPatrol = false
		getOwner.get_node("States/Battling").show()
		getOwner.get_node("States/Patrol").hide()
		getOwner.get_node("Enemy/Looking_Zone/Zone").get_surface_material(0).albedo_color = Color(1, 0, 0, 0.05)
		area.queue_free()
		check_life()
