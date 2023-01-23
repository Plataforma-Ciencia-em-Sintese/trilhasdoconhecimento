extends Spatial

export (NodePath) var animationTree
export var speed = 1
export (String, "idle", "walk","moving around") var states
var start = true
var changeAnimMvgAround = 0

func _ready():
	pass
	
func _physics_process(delta):
	if is_visible_in_tree():
		owner.offset += speed * delta
		if start:
			state_npc(states)
			start = false
			
func state_npc(value):
	randomize()
	
	if value == "idle":
		get_node(animationTree).get("parameters/moving/playback").travel("Idle")
	elif value == "walk":
		get_node(animationTree).get("parameters/moving/playback").travel("Walk")
	elif value == "moving around":
		get_node(animationTree).get("parameters/moving/playback").travel("Walk")
		speed = 1
		$Timer.wait_time = rand_range(1,2)
		$Timer.start()

func _on_Timer_timeout():
	randomize()
	$Timer.wait_time = rand_range(1,2)	
	changeAnimMvgAround = randi()% 2
	
	if changeAnimMvgAround == 0:
		get_node(animationTree).get("parameters/moving/playback").travel("Walk")
		speed = 1
	elif changeAnimMvgAround == 1:
		get_node(animationTree).get("parameters/moving/playback").travel("Idle")
		speed = 0
