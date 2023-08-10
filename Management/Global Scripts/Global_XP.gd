extends Node

# Signal global
# Todos os objetos que precisam checar o xp devem possuir esse signal conectado
signal xp(val)

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_up"):
		set_xp(5)
	elif Input.is_action_just_pressed("ui_left"):
		set_xp(35)

func set_xp(value):
	# Manda o signal com o valor do xp para a ui Status
	emit_signal("xp",value)

