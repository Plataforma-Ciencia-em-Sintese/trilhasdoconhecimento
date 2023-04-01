extends Spatial

var loop = true
onready var target = get_tree().get_nodes_in_group("Player")[0].get_node("States/Battling").actualEnemy

func _ready():
	if target != null:
		global_transform.origin = Vector3(target.global_transform.origin.x,global_transform.origin.y,target.global_transform.origin.z)
		target.owner.get_node("States/Colaterals").paralized = true
		target = null
	else:
		$EffekseerEmitter.queue_free()
		$Timer.stop()
		$Timer.queue_free()

func _physics_process(delta):
	if target != null:
		queue_free()

func _on_Timer_timeout():
	$EffekseerEmitter.play()
	yield(get_tree().create_timer(0.5),"timeout")
	$EffekseerEmitter.stop()
