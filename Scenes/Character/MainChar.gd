extends KinematicBody

export (String, "Ariel","Bento","Caio","Clara","Yara") var mainChar
export (String, "Normal","Armadura") var activeCloths
export var mainGun = "Arco"

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
  # Parte dos buttons
		$Inventory/BT_Inventario.show()
		$TabletInformation/BT_tablet.hide()
	else:
		$Base/Skeleton/Body.mesh = load(suits[mainChar][1])
		$Battle_UI.show()
		change_weapons()
# Parte dos buttons
		$Inventory/BT_Inventario.hide()
		$TabletInformation/BT_tablet.show()

	if GlobalValues.whiteScreen:
		get_tree().get_nodes_in_group("WhiteTransition")[0].get_node("AnimationPlayer").play("FadeOut")
	
	if QuestManager.isInQuest:
		QuestManager.player = self
		create_btns_battle("ATK")
		create_btns_battle("Consum")
		
# cria os botoes que serao necessarios a batalha
func create_btns_battle(value):
	if value == "ATK":
		#destruir botoes
		for i in $Battle_UI/Attack_Container.get_child_count():
			$Battle_UI/Attack_Container.get_child(i).queue_free()
			
		#adicionar itens
		var atkButtonScene = load("res://Scenes/Attacks/Button Commands/ATK.tscn")
		for i in GlobalValues.atkItens.size():
			var ATKBtn = atkButtonScene.instance()
#			ATKBtn.cooldownValue = GlobalValues.atkItens.values()[i][0]
			ATKBtn.attackSource = GlobalValues.atkItens.values()[i][0]
			ATKBtn.icon = load(GlobalValues.atkItens.values()[i][1])
			ATKBtn.followPlayer = GlobalValues.atkItens.values()[i][3]
			$Battle_UI/Attack_Container.add_child(ATKBtn)
	elif value == "Consum":
		#destruir botoes
		for i in $Battle_UI/Consumable_Container.get_child_count():
			$Battle_UI/Consumable_Container.get_child(i).queue_free()
			
		#adicionar itens
		var consumButtonScene = load("res://Scenes/Consumables/Button Commands/Consumable.tscn")
		for i in GlobalValues.consumItens.size():
			var ConsumBtn = consumButtonScene.instance()
			ConsumBtn.icon = load(GlobalValues.consumItens.values()[i][1])
			ConsumBtn.orbType = GlobalValues.consumItens.values()[i][0]
			ConsumBtn.keyName = GlobalValues.consumItens.keys()[i]
			$Battle_UI/Consumable_Container.add_child(ConsumBtn)


func change_weapons():
	if mainGun == "Escudo":
		$Base/Skeleton/BoneAttachmentR/Hammer.show()
		$Base/Skeleton/BoneAttachmentL/Shield.show()
		$Base/Skeleton/BoneAttachmentR/Sword.hide()
		$Base/Skeleton/BoneAttachmentR/Wand.hide()
		$Base/Skeleton/BoneAttachmentR/Bow.hide()
	elif mainGun == "Espada":
		$Base/Skeleton/BoneAttachmentR/Hammer.hide()
		$Base/Skeleton/BoneAttachmentL/Shield.hide()
		$Base/Skeleton/BoneAttachmentR/Sword.show()
		$Base/Skeleton/BoneAttachmentR/Wand.hide()
		$Base/Skeleton/BoneAttachmentR/Bow.hide()
	elif mainGun == "Varinha":
		$Base/Skeleton/BoneAttachmentR/Hammer.hide()
		$Base/Skeleton/BoneAttachmentL/Shield.hide()
		$Base/Skeleton/BoneAttachmentR/Sword.hide()
		$Base/Skeleton/BoneAttachmentR/Wand.show()
		$Base/Skeleton/BoneAttachmentR/Bow.hide()
	elif mainGun == "Arco":
		$Base/Skeleton/BoneAttachmentR/Hammer.hide()
		$Base/Skeleton/BoneAttachmentL/Shield.hide()
		$Base/Skeleton/BoneAttachmentR/Sword.hide()
		$Base/Skeleton/BoneAttachmentR/Wand.hide()
		$Base/Skeleton/BoneAttachmentR/Bow.show()
	elif mainGun == "Manopla":
		$Base/Skeleton/BoneAttachmentR/Hammer.hide()
		$Base/Skeleton/BoneAttachmentL/Shield.hide()
		$Base/Skeleton/BoneAttachmentR/Sword.hide()
		$Base/Skeleton/BoneAttachmentR/Wand.hide()
		$Base/Skeleton/BoneAttachmentR/Bow.hide()
	else:
		$Base/Skeleton/BoneAttachmentR/Hammer.hide()
		$Base/Skeleton/BoneAttachmentL/Shield.hide()
		$Base/Skeleton/BoneAttachmentR/Sword.show()
		$Base/Skeleton/BoneAttachmentR/Wand.hide()
		$Base/Skeleton/BoneAttachmentR/Bow.hide()
		
func choose_chip(value):
	if value != "":
		var chipScene = load(value).instance()
		$Base/Skeleton.add_child(chipScene)
		$Status/Life_Bar.max_value = 100 + chipScene.lifeBoost
		$Status/Energy_Bar.max_value = 100 + chipScene.energyBoost
		$States/Move.speedRun = 1.0 + chipScene.speedBoost
		$States/Move.speedWalk = 1.0 + chipScene.speedBoost
	else:
		$Status/Life_Bar.max_value = 100
		$Status/Energy_Bar.max_value = 100
		$States/Move.speedRun = 1.0
		$States/Move.speedWalk = 1.0
	

