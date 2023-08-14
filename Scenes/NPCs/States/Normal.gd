extends Spatial

export (NodePath) var animationTree
export (float) var speed = 1
export (String, "idle", "walk","moving around") var states
var start : bool = true
var lockMovingArround : bool = false
var changeAnimMvgAround : int = 0

func _physics_process(delta):
	if is_visible_in_tree():
		if start:
			owner.offset += speed * delta
			state_npc(states)

func state_npc(value):
	randomize()
	
	if value == "idle":
		get_node(animationTree).get("parameters/moving/playback").travel("Idle")
	elif value == "walk":
		get_node(animationTree).get("parameters/moving/playback").travel("Walk")
		speed = 1
	elif value == "moving around":
		if !lockMovingArround:
			get_node(animationTree).get("parameters/moving/playback").travel("Idle")
			$Timer.wait_time = rand_range(1,2)
			$Timer.start()
			lockMovingArround = true
		
func _on_Timer_timeout():
	randomize()
	$Timer.wait_time = rand_range(1,2)
	changeAnimMvgAround = randi()% 2
	
	if changeAnimMvgAround == 0:
		get_node(animationTree).get("parameters/moving/playback").travel("Walk")
		speed = 1
		start = true
	elif changeAnimMvgAround == 1:
		get_node(animationTree).get("parameters/moving/playback").travel("Idle")
		speed = 0
		start = false
