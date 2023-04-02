extends KinematicBody

var armors = {
	"Ariel":"res://3D/Character Oficial/Ariel/Ariel Armadura.tres",
	"Bento":"res://3D/Character Oficial/Bento/Bento Armadura.tres",
	"Clara":"res://3D/Character Oficial/Clara/Clara Armadura.tres",
	"Caio":"res://3D/Character Oficial/Caio/Caio Armadura.tres",
	"Yara":"res://3D/Character Oficial/Yara/Yara Armadura.tres"
}
var getEnemies 
onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	$Skeleton/Mesh.mesh = load(armors.get(GlobalValues.nameChar))
	getEnemies = get_tree().get_nodes_in_group("RootEnemy")
	for i in getEnemies.size():
		getEnemies[i].get_node("States/Battling").clone = self

func _on_Timer_timeout():
	getEnemies = get_tree().get_nodes_in_group("RootEnemy")
	for i in getEnemies.size():
		getEnemies[i].get_node("States/Battling").clone = null
