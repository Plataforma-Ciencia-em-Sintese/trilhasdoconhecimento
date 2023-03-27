extends Area

export var speed = 80
var dir = Vector3()

func _physics_process(delta):
	global_translate(-dir * speed * delta)

func _on_Timer_timeout():
	queue_free()
