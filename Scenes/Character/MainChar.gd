extends KinematicBody

# Seta as caracteristicas do player
export (String, "Ariel","Bento","Caio","Clara","Yara") var mainChar
export (String, "Normal","Armadura") var activeCloths

# Armazena as armas atuais
export var mainGun : String = ""
export var secGun : String = ""

# Armazena os nodes da cena Player para esconder quando for necessario
export (Array,NodePath) var nodesToHide

# Resource de som do jogador
export (Resource) var soundResource

# Identifica qual arma esta atualmente sendo usada
var selectedGun : String = ""

# Coleta o inventario
onready var invent : Node = $Inventory

# Checa se tem alguma camera cinematica na cena
export var getCineCam : bool = false

# Pega o node do esqueleto do player
onready var bodySkeleton : Node = $Base/Skeleton/Body

# Pega a interface de batalha do jogo
onready var battleUI : Node = $Battle_UI

# Armazena todas as armas 3D que ja estao dentro do Player
onready var hammerWeapon : Node = $Base/Skeleton/BoneAttachmentR/Hammer
onready var shieldWeapon : Node = $Base/Skeleton/BoneAttachmentL/Shield
onready var swordWeapon : Node = $Base/Skeleton/BoneAttachmentR/Sword
onready var wandWeapon : Node = $Base/Skeleton/BoneAttachmentR/Wand
onready var bowWeapon : Node = $Base/Skeleton/BoneAttachmentR/Bow

# Identifica aonde estao o corpo e a armadura .tres de cada jogador nos arquivos
var suits = {
	"Ariel": ["res://3D/Character Oficial/Ariel/Ariel Normal.tres","res://3D/Character Oficial/Ariel/Ariel Armadura.tres"],
	"Bento": ["res://3D/Character Oficial/Bento/Bento Normal.tres","res://3D/Character Oficial/Bento/Bento Armadura.tres"],
	"Caio": ["res://3D/Character Oficial/Caio/Caio Normal.tres","res://3D/Character Oficial/Caio/Caio Armadura.tres"],
	"Clara": ["res://3D/Character Oficial/Clara/Clara Normal.tres","res://3D/Character Oficial/Clara/Clara Armadura.tres"],
	"Yara": ["res://3D/Character Oficial/Yara/Yara Normal.tres","res://3D/Character Oficial/Yara/Yara Armadura.tres"]
}

func _ready():
	# Seta quem e o jogador de acordo com os valores das variaveis
	mainChar = GlobalValues.nameChar
	activeCloths = GlobalValues.skinChar
	if activeCloths == "Normal":
		bodySkeleton.mesh = load(suits[mainChar][0])
		battleUI.hide()
	else:
		bodySkeleton.mesh = load(suits[mainChar][1])
		battleUI.show()
		change_weapons(selectedGun)

	if GlobalValues.whiteScreen:
		get_tree().get_nodes_in_group("WhiteTransition")[0].get_node("AnimationPlayer").play("FadeOut")
	
	# Identifica a camera cinematica da fase caso seja necessario e inicia o modo cutscene
	if getCineCam:
		var cineCamera = get_tree().get_nodes_in_group("CineCamera")[0]
		cineCamera.connect("camera_activated",self,"cinematic_mode")

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_select"):
		get_tree().reload_current_scene()
#		get_tree().change_scene("res://Scenes/Sci Fi Room/Debug_Boss_Room.tscn")

func change_weapons(weapon):
	# Checa qual arma e a atual e troca de acordo com o parametro
	selectedGun = weapon
	if weapon == "Escudo":
		hammerWeapon.show()
		shieldWeapon.show()
		swordWeapon.hide()
		wandWeapon.hide()
		bowWeapon.hide()
	elif weapon == "Espada":
		hammerWeapon.hide()
		shieldWeapon.hide()
		swordWeapon.show()
		wandWeapon.hide()
		bowWeapon.hide()
	elif weapon == "Varinha":
		hammerWeapon.hide()
		shieldWeapon.hide()
		swordWeapon.hide()
		wandWeapon.show()
		bowWeapon.hide()
	elif weapon == "Arco":
		hammerWeapon.hide()
		shieldWeapon.hide()
		swordWeapon.hide()
		wandWeapon.hide()
		bowWeapon.show()
	elif weapon == "Manopla":
		hammerWeapon.hide()
		shieldWeapon.hide()
		swordWeapon.hide()
		wandWeapon.hide()
		bowWeapon.hide()
	else:
		hammerWeapon.hide()
		shieldWeapon.hide()
		swordWeapon.hide()
		wandWeapon.hide()
		bowWeapon.hide()

func cinematic_mode(status):
	# Se o signal vindo da camera e iniciar ou terminar
	if status == "started":
		for i in nodesToHide.size():
			get_node(nodesToHide[i]).hide()
	else:
		for i in nodesToHide.size():
			get_node(nodesToHide[i]).show()
