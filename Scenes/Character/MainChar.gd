extends KinematicBody

export (String, "Ariel","Bento","Caio","Clara","Yara") var mainChar
export (String, "Normal","Armadura") var activeCloths
export var mainGun = "Arco"
export var secGun = "Varinha"
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
#		$Inventory/BT_Inventario.hide()
		$TabletInformation/BT_tablet.show()

	if GlobalValues.whiteScreen:
		get_tree().get_nodes_in_group("WhiteTransition")[0].get_node("AnimationPlayer").play("FadeOut")
	
	if QuestManager.isInQuest:
		QuestManager.player = self
#	create_btns_battle("ATK")
	create_btns_battle("Consum")

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_select"):
		print("Life - " + str(GlobalValues.lifeBoost) + "\nEnergy - " + str(GlobalValues.energyBoost) + "\nSpeedWalk - " + str(GlobalValues.speedBoostWalk) +  "\nSpeedRun - " + str(GlobalValues.speedBoostRun) + "\nAttack - " + str(GlobalValues.atkBoost))

# cria os botoes que serao necessarios a batalha
func create_btns_battle(value):
	if value == "ATK":
		#destruir botoes
		for i in $Battle_UI/Weapon_Container.get_child_count():
			$Battle_UI/Weapon_Container.get_child(i).queue_free()
		for i in $Battle_UI/Weapon_Sec_Container.get_child_count():
			$Battle_UI/Weapon_Sec_Container.get_child(i).queue_free()
			
		#adicionar itens
		var atkButtonScene = load("res://Scenes/Attacks/Button Commands/ATK.tscn")
		for i in GlobalValues.atkItens.size():
			var ATKBtn = atkButtonScene.instance()
#			ATKBtn.cooldownValue = GlobalValues.atkItens.values()[i][0]
			ATKBtn.attackSource = GlobalValues.atkItens.values()[i][0]
			ATKBtn.icon = load(GlobalValues.atkItens.values()[i][1])
			ATKBtn.followPlayer = GlobalValues.atkItens.values()[i][3]
			ATKBtn.lvlToUnlock = GlobalValues.atkItens.values()[i][4]
			$Battle_UI/Weapon_Container.add_child(ATKBtn)

		for i in GlobalValues.atkItensSec.size():
			var ATKBtn = atkButtonScene.instance()
#			ATKBtn.cooldownValue = GlobalValues.atkItens.values()[i][0]
			ATKBtn.attackSource = GlobalValues.atkItensSec.values()[i][0]
			ATKBtn.icon = load(GlobalValues.atkItensSec.values()[i][1])
			ATKBtn.followPlayer = GlobalValues.atkItensSec.values()[i][3]
			ATKBtn.lvlToUnlock = GlobalValues.atkItensSec.values()[i][4]
			$Battle_UI/Weapon_Sec_Container.add_child(ATKBtn)
		
		yield(get_tree().create_timer(0.1),"timeout")
		for i in invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons/Weapons_Main_Abilities").get_child_count():
			invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons/Weapons_Main_Abilities").get_child(i).queue_free()
		for i in invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons_Sec/Weapons_Sec_Abilities").get_child_count():
			invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons_Sec/Weapons_Sec_Abilities").get_child(i).queue_free()
			
		for i in GlobalValues.atkItens.size():
			var ATKInventBTN = atkButtonScene.instance()
			ATKInventBTN.attackSource = GlobalValues.atkItens.values()[i][0]
			ATKInventBTN.icon = load(GlobalValues.atkItens.values()[i][1])
			ATKInventBTN.lvlToUnlock = GlobalValues.atkItens.values()[i][4]
			ATKInventBTN.disabled = true
			invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons/Weapons_Main_Abilities").add_child(ATKInventBTN)
		
		for i in GlobalValues.atkItensSec.size():
			var ATKInventBTN = atkButtonScene.instance()
			ATKInventBTN.attackSource = GlobalValues.atkItensSec.values()[i][0]
			ATKInventBTN.icon = load(GlobalValues.atkItensSec.values()[i][1])
			ATKInventBTN.lvlToUnlock = GlobalValues.atkItensSec.values()[i][4]
			ATKInventBTN.disabled = true
			invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons_Sec/Weapons_Sec_Abilities").add_child(ATKInventBTN)

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
	if mainGun == "Escudo" or secGun == "Escudo":
		$Base/Skeleton/BoneAttachmentR/Hammer.show()
		$Base/Skeleton/BoneAttachmentL/Shield.show()
		$Base/Skeleton/BoneAttachmentR/Sword.hide()
		$Base/Skeleton/BoneAttachmentR/Wand.hide()
		$Base/Skeleton/BoneAttachmentR/Bow.hide()
	elif mainGun == "Espada" or secGun == "Espada":
		$Base/Skeleton/BoneAttachmentR/Hammer.hide()
		$Base/Skeleton/BoneAttachmentL/Shield.hide()
		$Base/Skeleton/BoneAttachmentR/Sword.show()
		$Base/Skeleton/BoneAttachmentR/Wand.hide()
		$Base/Skeleton/BoneAttachmentR/Bow.hide()
	elif mainGun == "Varinha" or secGun == "Varinha":
		$Base/Skeleton/BoneAttachmentR/Hammer.hide()
		$Base/Skeleton/BoneAttachmentL/Shield.hide()
		$Base/Skeleton/BoneAttachmentR/Sword.hide()
		$Base/Skeleton/BoneAttachmentR/Wand.show()
		$Base/Skeleton/BoneAttachmentR/Bow.hide()
	elif mainGun == "Arco" or secGun == "Arco":
		$Base/Skeleton/BoneAttachmentR/Hammer.hide()
		$Base/Skeleton/BoneAttachmentL/Shield.hide()
		$Base/Skeleton/BoneAttachmentR/Sword.hide()
		$Base/Skeleton/BoneAttachmentR/Wand.hide()
		$Base/Skeleton/BoneAttachmentR/Bow.show()
	elif mainGun == "Manopla" or secGun == "Manopla":
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

func change_weapons_in_game(weapon):
	if weapon == "Escudo":
		$Base/Skeleton/BoneAttachmentR/Hammer.show()
		$Base/Skeleton/BoneAttachmentL/Shield.show()
		$Base/Skeleton/BoneAttachmentR/Sword.hide()
		$Base/Skeleton/BoneAttachmentR/Wand.hide()
		$Base/Skeleton/BoneAttachmentR/Bow.hide()
	elif weapon == "Espada":
		$Base/Skeleton/BoneAttachmentR/Hammer.hide()
		$Base/Skeleton/BoneAttachmentL/Shield.hide()
		$Base/Skeleton/BoneAttachmentR/Sword.show()
		$Base/Skeleton/BoneAttachmentR/Wand.hide()
		$Base/Skeleton/BoneAttachmentR/Bow.hide()
	elif weapon == "Varinha":
		$Base/Skeleton/BoneAttachmentR/Hammer.hide()
		$Base/Skeleton/BoneAttachmentL/Shield.hide()
		$Base/Skeleton/BoneAttachmentR/Sword.hide()
		$Base/Skeleton/BoneAttachmentR/Wand.show()
		$Base/Skeleton/BoneAttachmentR/Bow.hide()
	elif weapon == "Arco":
		$Base/Skeleton/BoneAttachmentR/Hammer.hide()
		$Base/Skeleton/BoneAttachmentL/Shield.hide()
		$Base/Skeleton/BoneAttachmentR/Sword.hide()
		$Base/Skeleton/BoneAttachmentR/Wand.hide()
		$Base/Skeleton/BoneAttachmentR/Bow.show()
	elif weapon == "Manopla":
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
	print("LIFEBOOST ATUAL " + str(GlobalValues.lifeBoost))
	print("ENERGY ATUAL " + str(GlobalValues.energyBoost))
	print("ATK ATUAL " + str(GlobalValues.atkBoost))
	print("SPEEDWALK ATUAL " + str(GlobalValues.speedBoostWalk))
	print("SPEEDRUN ATUAL " + str(GlobalValues.speedBoostRun))
	
	GlobalValues.lifeBoost -= GlobalValues.lifeBoostChip
	GlobalValues.energyBoost -= GlobalValues.energyBoostChip
	GlobalValues.atkBoost -= GlobalValues.atkBoostChip
	GlobalValues.speedBoostWalk -= GlobalValues.speedBoostWalkChip
	GlobalValues.speedBoostRun -= GlobalValues.speedBoostRunChip
	
	GlobalValues.lifeBoostChip = 0
	GlobalValues.energyBoostChip = 0
	GlobalValues.atkBoostChip = 0
	GlobalValues.speedBoostWalkChip = 0
	GlobalValues.speedBoostRunChip = 0

	if value != "":
		var chipScene = load(value).instance()
		$Base/Skeleton.add_child(chipScene)
		GlobalValues.lifeBoostChip = chipScene.lifeBoost
		GlobalValues.energyBoostChip = chipScene.energyBoost
		GlobalValues.speedBoostWalkChip = chipScene.speedBoostWalk
		GlobalValues.speedBoostRunChip = chipScene.speedBoostRun
		GlobalValues.XPBoostChip = chipScene.xpBoost
		GlobalValues.atkBoostChip = chipScene.atkBoost
		
		GlobalValues.lifeBoost += GlobalValues.lifeBoostChip
		GlobalValues.energyBoost += GlobalValues.energyBoostChip
		GlobalValues.atkBoost += GlobalValues.atkBoostChip
		GlobalValues.speedBoostWalk += GlobalValues.speedBoostWalkChip
		GlobalValues.speedBoostRun += GlobalValues.speedBoostRunChip
	else:
		GlobalValues.lifeBoost = 0
		GlobalValues.energyBoost = 0
		GlobalValues.atkBoost = 0
		GlobalValues.speedBoostWalk = 0
		GlobalValues.speedBoostRun = 0
		print("limpapapa")
	
	print("LIFEBOOST MUDADO " + str(GlobalValues.lifeBoost))
	print("ENERGY MUDADO " + str(GlobalValues.energyBoost))
	print("ATK MUDADO " + str(GlobalValues.atkBoost))
	print("SPEEDWALK MUDADO " + str(GlobalValues.speedBoostWalk))
	print("SPEEDRUN MUDADO " + str(GlobalValues.speedBoostRun))
		
func set_attributes():
	pass
#	GlobalValues.lifeBoost -= GlobalValues.lifeBoostWeapon
#	GlobalValues.energyBoost -= GlobalValues.energyBoostWeapon
#	GlobalValues.atkBoost -= GlobalValues.atkBoostWeapon
#	GlobalValues.speedBoostWalk -= GlobalValues.speedBoostWalkWeapon
#	GlobalValues.speedBoostRun -= GlobalValues.speedBoostRunWeapon
#
#	GlobalValues.lifeBoostWeapon = 0
#	GlobalValues.energyBoostWeapon = 0
#	GlobalValues.atkBoostWeapon = 0
#	GlobalValues.speedBoostWalkWeapon = 0
#	GlobalValues.speedBoostRunWeapon = 0
#
#	#Cominacoes de armas
#	if mainGun == "Espada" and secGun == "Escudo" or mainGun == "Escudo" and secGun == "Espada":
#		GlobalValues.lifeBoostWeapon += 25
#		GlobalValues.speedBoostWalkWeapon -= 1
#		GlobalValues.speedBoostRunWeapon -= 1
#	elif mainGun == "Manopla" and secGun == "Escudo" or mainGun == "Escudo" and secGun == "Manopla":
#		GlobalValues.lifeBoostWeapon += 15
#		GlobalValues.atkBoostWeapon -= 2
#		GlobalValues.speedBoostWalkWeapon += 1
#		GlobalValues.speedBoostRunWeapon += 1
#	elif mainGun == "Espada" and secGun == "Manopla" or mainGun == "Manopla" and secGun == "Espada":
#		GlobalValues.lifeBoostWeapon += 10
#		GlobalValues.speedBoostWalkWeapon += 2
#		GlobalValues.speedBoostRunWeapon += 2
#	elif mainGun == "Varinha" and secGun == "Escudo" or mainGun == "Escudo" and secGun == "Varinha":
#		GlobalValues.lifeBoostWeapon += 5
#		GlobalValues.speedBoostWalkWeapon -= 3
#		GlobalValues.speedBoostRunWeapon -= 3
#		GlobalValues.atkBoostWeapon += 2
#	elif mainGun == "Arco" and secGun == "Escudo" or mainGun == "Escudo" and secGun == "Arco":
#		GlobalValues.lifeBoostWeapon += 5
#		GlobalValues.energyBoostWeapon -= 10
#		GlobalValues.atkBoostWeapon += 2
#		GlobalValues.speedBoostWalkWeapon -= 1
#		GlobalValues.speedBoostRunWeapon -= 1
#	elif mainGun == "Varinha" and secGun == "Espada" or mainGun == "Espada" and secGun == "Varinha":
#		GlobalValues.atkBoostWeapon += 4
#		GlobalValues.speedBoostWalkWeapon -= 2
#		GlobalValues.speedBoostRunWeapon -= 2
#	elif mainGun == "Arco" and secGun == "Espada" or mainGun == "Espada" and secGun == "Arco":
#		GlobalValues.energyBoostWeapon -= 10
#		GlobalValues.speedBoostWalkWeapon += 4
#		GlobalValues.speedBoostRunWeapon += 4
#	elif mainGun == "Varinha" and secGun == "Manopla" or mainGun == "Manopla" and secGun == "Varinha":
#		GlobalValues.lifeBoostWeapon -= 10
#		GlobalValues.atkBoostWeapon += 2
#	elif mainGun == "Arco" and secGun == "Manopla" or mainGun == "Manopla" and secGun == "Arco":
#		GlobalValues.lifeBoostWeapon -= 10
#		GlobalValues.energyBoostWeapon -= 10
#		GlobalValues.atkBoostWeapon += 2
#		GlobalValues.speedBoostWalkWeapon += 2
#		GlobalValues.speedBoostRunWeapon += 2
#	elif mainGun == "Varinha" and secGun == "Arco" or mainGun == "Arco" and secGun == "Varinha":
#		GlobalValues.lifeBoostWeapon -= 20
#		GlobalValues.energyBoostWeapon -= 10
#		GlobalValues.atkBoostWeapon += 6
#		GlobalValues.speedBoostWalkWeapon -= 2
#		GlobalValues.speedBoostRunWeapon -= 2
#	# Armas Solo
#	elif mainGun == "Varinha" and secGun == "":
#		GlobalValues.lifeBoostWeapon -= 100/3
#		GlobalValues.atkBoostWeapon += 100/2
#		GlobalValues.speedBoostWalkWeapon -= 100/2
#		GlobalValues.speedBoostRunWeapon -= 100/2
#	elif mainGun == "Arco" and secGun == "":
#		GlobalValues.lifeBoostWeapon -= 100/3
#		GlobalValues.energyBoostWeapon -= 100/3
#		GlobalValues.atkBoostWeapon += 100/2
#	elif mainGun == "Espada" and secGun == "":
#		GlobalValues.lifeBoostWeapon += 100/3
#		GlobalValues.atkBoostWeapon += 100/6
#	elif mainGun == "Manopla" and secGun == "":
#		GlobalValues.speedBoostWalkWeapon += 100/2
#		GlobalValues.speedBoostRunWeapon += 100/2
#		GlobalValues.atkBoostWeapon -= 100/6
#	elif mainGun == "Escudo" and secGun == "":
#		GlobalValues.lifeBoostWeapon += 100/2
#		GlobalValues.atkBoostWeapon -= 100/6
#		GlobalValues.speedBoostWalkWeapon -= $States/Move.speedWalkChoosed/4
#		GlobalValues.speedBoostRunWeapon -= $States/Move.speedRunChoosed/4
#
#	GlobalValues.lifeBoost += GlobalValues.lifeBoostWeapon
#	GlobalValues.energyBoost += GlobalValues.energyBoostWeapon
#	GlobalValues.atkBoost += GlobalValues.atkBoostWeapon
#	GlobalValues.speedBoostWalk += GlobalValues.speedBoostWalkWeapon
#	GlobalValues.speedBoostRun += GlobalValues.speedBoostRunWeapon
	
func change_UI_status():
	$Status/Life_Bar.max_value = 100 + GlobalValues.lifeBoost
	$Status/Energy_Bar.max_value = 100 + GlobalValues.energyBoost
	$States/Move.speedRun = $States/Move.speedRunChoosed + GlobalValues.speedBoostRun
	$States/Move.speedWalk = $States/Move.speedWalkChoosed + GlobalValues.speedBoostWalk
	print("mudado")
