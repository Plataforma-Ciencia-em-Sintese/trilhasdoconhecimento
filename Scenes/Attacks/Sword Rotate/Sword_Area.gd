extends Area

export var speed = 20
var statsCol = true

func _physics_process(delta):
	rotate_y(speed * delta)

func _on_Timer_timeout():
	statsCol = !statsCol
	$CollisionShape.set_deferred("disabled",statsCol)
