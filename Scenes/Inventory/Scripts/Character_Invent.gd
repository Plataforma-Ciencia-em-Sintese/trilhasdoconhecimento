extends KinematicBody
export (String, "Ariel","Bento","Caio","Clara","Yara") var mainChar
export (String, "Normal","Armadura") var activeCloths
export var mainGun = "Arco"
export var secGun = "Espada"
var  selectedGun = "Espada"
onready var invent = get_tree().get_nodes_in_group("Inventory")[0]

var suits = {
	"Ariel": ["res://3D/Character Oficial/Ariel/Ariel Normal.tres","res://3D/Character Oficial/Ariel/Ariel Armadura.tres"],
	"Bento": ["res://3D/Character Oficial/Bento/Bento Normal.tres","res://3D/Character Oficial/Bento/Bento Armadura.tres"],
	"Caio": ["res://3D/Character Oficial/Caio/Caio Normal.tres","res://3D/Character Oficial/Caio/Caio Armadura.tres"],
	"Clara": ["res://3D/Character Oficial/Clara/Clara Normal.tres","res://3D/Character Oficial/Clara/Clara Armadura.tres"],
	"Yara": ["res://3D/Character Oficial/Yara/Yara Normal.tres","res://3D/Character Oficial/Yara/Yara Armadura.tres"]
}

func _ready():
	mainChar = GlobalValues.nameChar
#	activeCloths = GlobalValues.skinChar
	if activeCloths == "Normal":
		$Base/Skeleton/Body.mesh = load(suits[mainChar][0])

	else:
		$Base/Skeleton/Body.mesh = load(suits[mainChar][1])

