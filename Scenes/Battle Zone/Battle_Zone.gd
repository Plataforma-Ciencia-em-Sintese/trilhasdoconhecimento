extends Spatial

export (int, "Lab", "Space") var stageID
export (Array,String) var battleStages
var transition = load("res://Scenes/Transitions/Transtiton.tscn")
var enemyNormal = load("res://Scenes/Enemies/Normal_Enemies.tscn")
var enemyQuant = 3
var enemyType = "Parafuso"

func _ready():
	var spawnTr = transition.instance()
	add_child(spawnTr)
	spawnTr.get_node("AnimationPlayer").play("Out")
	
	var spawnStage = load(battleStages[stageID]).instance()
	add_child(spawnStage)
	
	for i in $Enemy_Spawn.get_child_count():
		var spawnEnemy = enemyNormal.instance()
		spawnEnemy.scale = Vector3(0.404,0.404,0.404)
		spawnEnemy.enemyType = enemyType
		add_child(spawnEnemy)
		spawnEnemy.global_transform.origin = $Enemy_Spawn.get_child(i).global_transform.origin
		spawnEnemy.battle_initial()
	
	$Player.get_node("Inventory").hide()
	$Player.get_node("Pause").hide()
	$Player.get_node("Life").hide()
	$Pointer.isStopped = true
		
func _physics_process(delta):
	$Path_Cam/PathFollow.offset += 2 * delta
	if $Path_Cam/PathFollow.unit_offset >= 1:
		yield(get_tree().create_timer(2),"timeout")
		$Path_Cam/PathFollow/Camera_Overview.current = false
		$Player.get_node("Inventory").show()
		$Player.get_node("Pause").show()
		$Player.get_node("Life").show()
		$UI/BG.hide()
		$Pointer.isStopped = false
