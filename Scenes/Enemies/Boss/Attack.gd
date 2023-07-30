extends Spatial

export var timeToAtk = 2
var atks = ["ATKEspecial_02_Boss01","ATKEspecial_03_Boss01"]
var look = false
var isAttacking = false
var longRange = false
var dist
onready var player = get_tree().get_nodes_in_group("Player")[0]

func _physics_process(delta):
	if look:
		look_to_player()
	
	if Input.is_action_just_pressed("ui_down"):
		owner.get_node("States/Move").show()
	
	dist = owner.global_transform.origin.distance_to(player.global_transform.origin)
	if dist < 4:
		if !isAttacking:
			owner.get_node("AnimationPlayer").play("ATKNormal_Boss01")
		activate_move(false)
		longRange = false
	elif dist < 5:
		if !isAttacking:
			owner.get_node("AnimationPlayer").play("ATKEspecial_01_Boss01")
		activate_move(false)
		longRange = false
	else:
		longRange = true
		
func look_to_player():
	var target_global_pos = player.global_transform.origin
	var self_global_pos = owner.global_transform.origin

	var y_distance = target_global_pos.y - self_global_pos.y
	var look_at_position = Vector3(target_global_pos.x, self_global_pos.y, target_global_pos.z)

	owner.look_at(look_at_position, Vector3.UP)

func activate_move(status):
	if status:
		owner.get_node("States/Move").show()
		isAttacking = false
		if longRange:
			owner.get_node("AtkTimer").start()
	else:
		owner.get_node("States/Move").hide()
		isAttacking = true

func activate_look(status):
	look = status

func _on_AtkTimer_timeout():
	if !isAttacking and longRange:
		randomize()
		var chooseAtk = randi()%atks.size()
		owner.get_node("AnimationPlayer").play(atks[chooseAtk])
		activate_move(false)
		print(chooseAtk)
	
