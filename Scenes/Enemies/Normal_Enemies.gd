extends PathFollow

export (String, "Parafuso", "Serra", "Golem", "Flexivel", "Bala") var enemyType
export var speed = 1.0

func _ready():
	get_enemy(enemyType)

func _physics_process(delta):
	offset += speed * delta

func get_enemy(type):
	for i in $Enemy.get_children():
		if i.name != type:
			i.queue_free()
