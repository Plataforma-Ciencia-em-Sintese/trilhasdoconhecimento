extends PathFollow

export (String, "Parafuso", "Serra", "Golem", "Flexivel", "Bala") var enemyType
export var speed = 1.0
var transition = load("res://Scenes/Transitions/Transtiton.tscn")

func _ready():
	get_enemy(enemyType)

func _physics_process(delta):
	offset += speed * delta

func get_enemy(type):
	for i in $Root_Enemies.get_children():
		if i.name != type:
			i.queue_free()

func _on_Enemy_body_entered(body):
	if body.is_in_group("Player"):
		var spawnTr = transition.instance()
		add_child(spawnTr)
		spawnTr.get_node("AnimationPlayer").play("In")
		get_tree().paused = true
