extends Spatial

var speed = 1
export var distanceToStop = 2
var backToPatrol = false
var coolDown = false
var holdCooldown = false
var ally
var allyBarLife
var player
#var explosion = load("res://Effects/Toon Explosion/Explosion.tscn")
var hit = load("res://Scenes/Attacks/Hit/Hit.tscn")
var bigHit = load("res://Scenes/Attacks/Big Hit/Big Hit.tscn")
var dir
var vel

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	owner = owner

func _physics_process(_delta):
	if is_visible_in_tree():
		start_healing()

func start_healing():
	if !backToPatrol:
		var distanceToAlly
		distanceToAlly = owner.get_node("Enemy").global_transform.origin.distance_to(ally.global_transform.origin) - 0.1
		dir = ally.global_transform.origin - owner.get_node("Enemy").global_transform.origin
		vel = dir * speed
		
		var target_global_pos = ally.global_transform.origin
		var self_global_pos = owner.get_node("Enemy").global_transform.origin
		var look_at_position = Vector3(target_global_pos.x, self_global_pos.y, target_global_pos.z)
		owner.get_node("Enemy").look_at(look_at_position, Vector3.UP)
		
		if distanceToAlly <= distanceToStop:
			if owner.enemyResource.haveCooldown:
				if !coolDown:
					if !holdCooldown:
						owner.get_node("CoolDown").start(owner.enemyResource.cooldown)
						holdCooldown = true
					owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayer").play("Attack")
					if allyBarLife.value < allyBarLife.max_value:
						allyBarLife.value += 0.05
					else:
						backToPatrol = true
						owner.get_node("CoolDown").stop()
						holdCooldown = false
						coolDown = false
				else:
					owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayer").play("Idle")
			else:
				owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayer").play("Attack")
				if allyBarLife.value < allyBarLife.max_value:
					allyBarLife.value += 0.05
				else:
					backToPatrol = true
		else:
			owner.get_node("CoolDown").stop()
			holdCooldown = false
			coolDown = false
			owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayer").play("Idle")
		#---------------------------	
		owner.get_node("Enemy").move_and_slide(vel.normalized() * speed,Vector3.UP)
	else:
		ally = null
		allyBarLife = null
		owner.get_node("Enemy/Root_Enemies").get_child(0).get_node("AnimationPlayer").play("Idle")
		
		var distanceToPatrol = owner.get_node("Enemy").global_transform.origin.distance_to(owner.get_node("LastPos").global_transform.origin) - 0.1
		
		if distanceToPatrol <= 0.1:
			owner.disable_looking_collision()
			owner.get_node("States/Patrol").show()
			owner.get_node("States/Healing").hide()
			self.hide()
		else:
			dir = owner.get_node("LastPos").global_transform.origin - owner.get_node("Enemy").global_transform.origin
			vel = dir * speed
			owner.get_node("Enemy").look_at(owner.get_node("LastPos").global_transform.origin,Vector3.UP)
			owner.get_node("Enemy").move_and_slide(vel.normalized() * speed,Vector3.UP)
			
func _on_CoolDown_timeout():
	coolDown = !coolDown
	holdCooldown = false
