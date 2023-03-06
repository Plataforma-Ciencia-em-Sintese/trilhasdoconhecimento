extends PathFollow

export (String, "Parafuso", "Serra", "Golem", "Flexivel", "Bala") var enemyType
export var speed = 1.0
var transition = load("res://Scenes/Transitions/Transtiton.tscn")
var isOnBattle = false
onready var player

func _ready():
	get_enemy(enemyType)

func _physics_process(delta):
	offset += speed * delta

func get_enemy(type):
	for i in $Root_Enemies.get_children():
		if i.name != type:
			i.queue_free()

func battle_initial():
	isOnBattle = true
	player = get_tree().get_nodes_in_group("Player")[0]
	$Root_Enemies.look_at(-player.transform.origin,Vector3.UP)
	
func _on_Enemy_body_entered(body):
	if body.is_in_group("Player") and !isOnBattle:
		var spawnTr = transition.instance()
		add_child(spawnTr)
		spawnTr.get_node("AnimationPlayer").play("In")
		get_tree().paused = true
		yield(get_tree().create_timer(2),"timeout")
		get_tree().change_scene("res://Scenes/Battle Zone/Battle_Zone.tscn")
		get_tree().paused = false
