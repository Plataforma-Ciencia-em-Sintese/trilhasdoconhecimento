extends Spatial

onready var player = get_tree().get_nodes_in_group("Player")[0]
var multipleBullet = load("res://Scenes/Attacks/Projectiles/Special_Bullet.tscn")

func _ready():
	for i in 5:
		var bullet = multipleBullet.instance()
		get_parent().get_parent().get_parent().add_child(bullet)
		bullet.global_transform = global_transform
		bullet.dir = -bullet.global_transform.basis.z
		yield(get_tree().create_timer(0.1),"timeout")
