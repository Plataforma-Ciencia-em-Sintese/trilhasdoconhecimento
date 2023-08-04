extends Area

export (float) var speed = 1
#export var dir = Vector3()

func _physics_process(delta):
	translation += transform.basis.z * speed * delta

func _on_Timer_timeout():
	queue_free()
