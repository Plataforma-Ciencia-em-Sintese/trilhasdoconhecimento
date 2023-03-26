extends KinematicBody

export (String, "Ariel","Bento","Caio","Clara","Yara") var mainChar
export (String, "Normal","Armadura") var activeCloths

var suits = {
	"Ariel": ["res://3D/Character Oficial/Ariel/Ariel Normal.tres","res://3D/Character Oficial/Ariel/Ariel Armadura.tres"],
	"Bento": ["res://3D/Character Oficial/Bento/Bento Normal.tres","res://3D/Character Oficial/Bento/Bento Armadura.tres"],
	"Caio": ["res://3D/Character Oficial/Caio/Caio Normal.tres","res://3D/Character Oficial/Caio/Caio Armadura.tres"],
	"Clara": ["res://3D/Character Oficial/Clara/Clara Normal.tres","res://3D/Character Oficial/Clara/Clara Armadura.tres"],
	"Yara": ["res://3D/Character Oficial/Yara/Yara Normal.tres","res://3D/Character Oficial/Yara/Yara Armadura.tres"]
}

func _ready():
	mainChar = GlobalValues.nameChar
	activeCloths = GlobalValues.skinChar
	if activeCloths == "Normal":
		$Base/Skeleton/Body.mesh = load(suits[mainChar][0])
		$Battle_UI.hide()
		$Base/Skeleton/BoneAttachmentR/Sword.hide()
	else:
		$Base/Skeleton/Body.mesh = load(suits[mainChar][1])
		$Battle_UI.show()
		
		if mainChar == "Clara":
			$Base/Skeleton/BoneAttachmentR/Hammer.show()
			$Base/Skeleton/BoneAttachmentL/Shield.show()
		elif mainChar == "Caio":
			$Base/Skeleton/BoneAttachmentR/Sword.show()
		elif mainChar == "Bento":
			$Base/Skeleton/BoneAttachmentR/Wand.show()
		elif mainChar == "Yara":
			$Base/Skeleton/BoneAttachmentR/Bow.show()

	if GlobalValues.whiteScreen:
		get_tree().get_nodes_in_group("WhiteTransition")[0].get_node("AnimationPlayer").play("FadeOut")
	
	if QuestManager.isInQuest:
		QuestManager.player = self
		create_btns_battle("ATK")

# cria os botoes que serao necessarios a batalha
func create_btns_battle(value):
	if value == "ATK":
		var atkButtonScene = load("res://Scenes/Attacks/Button Commands/ATK.tscn")
		for i in GlobalValues.atkItens.size():
			var ATKBtn = atkButtonScene.instance()
			$Battle_UI/Attack_Container.add_child(ATKBtn)
			ATKBtn.cooldownValue = GlobalValues.atkItens.values()[i][0]
			ATKBtn.attackSource = GlobalValues.atkItens.values()[i][1]
			ATKBtn.icon = load(GlobalValues.atkItens.values()[i][2])
			ATKBtn.followPlayer = GlobalValues.atkItens.values()[i][4]
