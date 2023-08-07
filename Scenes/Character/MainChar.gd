extends KinematicBody

export (String, "Ariel","Bento","Caio","Clara","Yara") var mainChar
export (String, "Normal","Armadura") var activeCloths
export var mainGun = "Varinha"
export var secGun = "Espada"
export (Array,NodePath) var nodesToHide
var selectedGun = "Espada"
onready var invent = get_tree().get_nodes_in_group("Inventory")[0]
export var getCineCam = false

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

#	set_attributes("ATKMain")
#	set_attributes("ATKSec")
	#Precisa chamar de novo porque caso se um valor menor seja chamado pras barras, o max value nao enche a barra se ela encolher e depois aumentou
	$Status/Life_Bar.value = $Status/Life_Bar.max_value
	$Status/Energy_Bar.value = $Status/Energy_Bar.max_value
	
	if getCineCam:
		var cineCamera = get_tree().get_nodes_in_group("CineCamera")[0]
		cineCamera.connect("camera_activated",self,"cinematic_mode")

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_select"):
		get_tree().reload_current_scene()

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
			ATKBtn.costPower = GlobalValues.atkItens.values()[i][5]
			ATKBtn.check_lvl()
			$Battle_UI/Weapon_Container.add_child(ATKBtn)

		for i in GlobalValues.atkItensSec.size():
			var ATKBtn = atkButtonScene.instance()
#			ATKBtn.cooldownValue = GlobalValues.atkItens.values()[i][0]
			ATKBtn.attackSource = GlobalValues.atkItensSec.values()[i][0]
			ATKBtn.icon = load(GlobalValues.atkItensSec.values()[i][1])
			ATKBtn.followPlayer = GlobalValues.atkItensSec.values()[i][3]
			ATKBtn.lvlToUnlock = GlobalValues.atkItensSec.values()[i][4]
			ATKBtn.costPower = GlobalValues.atkItensSec.values()[i][5]
			ATKBtn.check_lvl()
			$Battle_UI/Weapon_Sec_Container.add_child(ATKBtn)
		
		yield(get_tree().create_timer(0.1),"timeout")
		for i in invent.get_node("BG_Inventory/Title_Weapon/Weapons_Main_Abilities").get_child_count():
			invent.get_node("BG_Inventory/Title_Weapon/Weapons_Main_Abilities").get_child(i).queue_free()
		for i in invent.get_node("BG_Inventory/Title_Weapon/Weapons_Sec_Abilities").get_child_count():
			invent.get_node("BG_Inventory/Title_Weapon/Weapons_Sec_Abilities").get_child(i).queue_free()
			
		for i in GlobalValues.atkItens.size():
			var ATKInventBTN = atkButtonScene.instance()
			ATKInventBTN.attackSource = GlobalValues.atkItens.values()[i][0]
			ATKInventBTN.icon = load(GlobalValues.atkItens.values()[i][1])
			ATKInventBTN.lvlToUnlock = GlobalValues.atkItens.values()[i][4]
			ATKInventBTN.disabled = true
			ATKInventBTN.check_lvl()
			invent.get_node("BG_Inventory/Title_Weapon/Weapons_Main_Abilities").add_child(ATKInventBTN)
		
		for i in GlobalValues.atkItensSec.size():
			var ATKInventBTN = atkButtonScene.instance()
			ATKInventBTN.attackSource = GlobalValues.atkItensSec.values()[i][0]
			ATKInventBTN.icon = load(GlobalValues.atkItensSec.values()[i][1])
			ATKInventBTN.lvlToUnlock = GlobalValues.atkItensSec.values()[i][4]
			ATKInventBTN.disabled = true
			ATKInventBTN.check_lvl()
			invent.get_node("BG_Inventory/Title_Weapon/Weapons_Sec_Abilities").add_child(ATKInventBTN)

	elif value == "Consum":
		#destruir botoes
#		for i in $Battle_UI/Consumable_Container.get_child_count():
#			$Battle_UI/Consumable_Container.get_child(i).queue_free()
#
#		#adicionar itens
#		var consumButtonScene = load("res://Scenes/Consumables/Button Commands/Consumable.tscn")
#		for i in GlobalValues.consumItens.size():
#			var ConsumBtn = consumButtonScene.instance()
#			ConsumBtn.icon = load(GlobalValues.consumItens.values()[i][1])
#			ConsumBtn.orbType = GlobalValues.consumItens.values()[i][0]
#			ConsumBtn.keyName = GlobalValues.consumItens.keys()[i]
#			$Battle_UI/Consumable_Container.add_child(ConsumBtn)
		pass
			
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
	selectedGun = weapon
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
		
func choose_chip(value,toDo):
	if toDo == "Add":
		var chipScene = load(value).instance()
		$Base/Skeleton.add_child(chipScene)
		if GlobalValues.lifeActual > 0:
			GlobalValues.lifeActual += chipScene.lifeBoost
		else:
			GlobalValues.lifeActual += GlobalValues.life + chipScene.lifeBoost
		
		if GlobalValues.energyActual > 0:
			GlobalValues.energyActual += chipScene.energyBoost
		else:
			GlobalValues.energyActual += GlobalValues.energy + chipScene.energyBoost
		
		if GlobalValues.speedActual > 0:
			GlobalValues.speedActual += chipScene.speedBoostRun
		else:
			GlobalValues.speedActual += GlobalValues.speed + chipScene.speedBoostRun
			
		GlobalValues.atkMainActual += chipScene.atkBoost
		GlobalValues.atkSecActual += chipScene.atkBoost
		GlobalValues.xpChip += chipScene.xpBoost
	else:
		var chipScene = load(value).instance()
		GlobalValues.lifeActual -= chipScene.lifeBoost
		GlobalValues.energyActual -= chipScene.energyBoost
		GlobalValues.atkMainActual -= chipScene.atkBoost
		GlobalValues.atkSecActual -= chipScene.atkBoost
		GlobalValues.speedActual -= chipScene.speedBoostRun
		GlobalValues.xpChip -= chipScene.xpBoost
		chipScene.queue_free()

	change_UI_status()
		
func set_attributes(typeAttribute):
	if typeAttribute == "ATKMain":
		if mainGun == "Espada":
			GlobalValues.atkMainActual += GlobalValues.atkMain + calculate_status(GlobalValues.atkMain,1,3)
			#-------
			if GlobalValues.lifeActual <= 0:
				GlobalValues.lifeActual += GlobalValues.life + calculate_status(GlobalValues.life,1,3)
			else:
				GlobalValues.lifeActual += calculate_status(GlobalValues.life,1,3)
		elif mainGun == "Arco":
			GlobalValues.atkMainActual += GlobalValues.atkMain + calculate_status(GlobalValues.atkMain,1,2)
			#-------
			if GlobalValues.energyActual <= 0:
				GlobalValues.energyActual += GlobalValues.energy - calculate_status(GlobalValues.energy,1,3)
			else:
				GlobalValues.energyActual -= calculate_status(GlobalValues.energy,1,3)
			#-------
			if GlobalValues.lifeActual <= 0:
				GlobalValues.lifeActual += GlobalValues.life - calculate_status(GlobalValues.life,1,3)
			else:
				GlobalValues.lifeActual -= calculate_status(GlobalValues.life,1,3)
		elif mainGun == "Varinha":
			GlobalValues.atkMainActual += GlobalValues.atkMain + calculate_status(GlobalValues.atkMain,1,2)
			#-------
			if GlobalValues.lifeActual <= 0:
				GlobalValues.lifeActual += GlobalValues.life - calculate_status(GlobalValues.life,1,3)
			else:
				GlobalValues.lifeActual -= calculate_status(GlobalValues.life,1,3)
			#-------
			if GlobalValues.speedActual <= 0:
				GlobalValues.speedActual += GlobalValues.speed - calculate_status(GlobalValues.speed,1,2)
			else:
				GlobalValues.speedActual -= calculate_status(GlobalValues.speed,1,2)
		elif mainGun == "Escudo":
			GlobalValues.atkMainActual += GlobalValues.atkMain - calculate_status(GlobalValues.atkMain,1,3) 
			#-------
			if GlobalValues.lifeActual <= 0:
				GlobalValues.lifeActual += GlobalValues.life + calculate_status(GlobalValues.life,1,2) 
			else:
				GlobalValues.lifeActual += calculate_status(GlobalValues.life,1,2) 
			#-------
			if GlobalValues.speedActual <= 0:
				GlobalValues.speedActual += GlobalValues.speed - calculate_status(GlobalValues.speed,1,4)
			else:
				GlobalValues.speedActual -= calculate_status(GlobalValues.speed,1,4)
		elif mainGun == "Manopla":
			GlobalValues.atkMainActual += GlobalValues.atkMain - calculate_status(GlobalValues.atkMain,1,3)
			#-------
			if GlobalValues.speedActual <= 0:
				GlobalValues.speedActual += GlobalValues.speed + calculate_status(GlobalValues.speed,1,2)
			else:
				GlobalValues.speedActual += calculate_status(GlobalValues.speed,1,2)
	elif typeAttribute == "ATKSec":
		if secGun == "Espada":
			GlobalValues.atkSecActual += GlobalValues.atkSec + calculate_status(GlobalValues.atkSec,1,3)
			#-------
			if GlobalValues.lifeActual <= 0:
				GlobalValues.lifeActual += GlobalValues.life + calculate_status(GlobalValues.life,1,3)
			else:
				GlobalValues.lifeActual += calculate_status(GlobalValues.life,1,3)
		elif secGun == "Arco":
			GlobalValues.atkSecActual += GlobalValues.atkSec + calculate_status(GlobalValues.atkSec,1,2)
			#-------
			if GlobalValues.energyActual <= 0:
				GlobalValues.energyActual += GlobalValues.energy - calculate_status(GlobalValues.energy,1,3)
			else:
				GlobalValues.energyActual -= calculate_status(GlobalValues.energy,1,3)
			#-------
			if GlobalValues.lifeActual <= 0:
				GlobalValues.lifeActual += GlobalValues.life - calculate_status(GlobalValues.life,1,3)
			else:
				GlobalValues.lifeActual -= calculate_status(GlobalValues.life,1,3)
		elif secGun == "Varinha":
			GlobalValues.atkSecActual += GlobalValues.atkSec + calculate_status(GlobalValues.atkSec,1,2)
			#-------
			if GlobalValues.lifeActual <= 0:
				GlobalValues.lifeActual += GlobalValues.life - calculate_status(GlobalValues.life,1,3)
			else:
				GlobalValues.lifeActual -= calculate_status(GlobalValues.life,1,3)
			#-------
			if GlobalValues.speedActual <= 0:
				GlobalValues.speedActual += GlobalValues.speed - calculate_status(GlobalValues.speed,1,2)
			else:
				GlobalValues.speedActual -= calculate_status(GlobalValues.speed,1,2)
		elif secGun == "Escudo":
			GlobalValues.atkSecActual += GlobalValues.atkSec - calculate_status(GlobalValues.atkSec,1,3) 
			#-------
			if GlobalValues.lifeActual <= 0:
				GlobalValues.lifeActual += GlobalValues.life + calculate_status(GlobalValues.life,1,2)
			else:
				GlobalValues.lifeActual += calculate_status(GlobalValues.life,1,2)
			#-------
			if GlobalValues.speedActual <= 0:
				GlobalValues.speedActual += GlobalValues.speed - calculate_status(GlobalValues.speed,1,4)
			else:
				GlobalValues.speedActual -= calculate_status(GlobalValues.speed,1,4)
		elif secGun == "Manopla":
			GlobalValues.atkSecActual += GlobalValues.atkSec - calculate_status(GlobalValues.atkSec,1,3)
			#-------
			if GlobalValues.speedActual <= 0:
				GlobalValues.speedActual += GlobalValues.speed + calculate_status(GlobalValues.speed,1,2)
			else:
				GlobalValues.speedActual += calculate_status(GlobalValues.speed,1,2)
			
	change_UI_status()

func clear_attributes(typeAttribute):
	if typeAttribute == "ATKMain":
		if mainGun == "Espada":
			GlobalValues.atkMainActual = 0
			GlobalValues.lifeActual -= calculate_status(GlobalValues.life,1,3)
		elif mainGun == "Arco":
			GlobalValues.atkMainActual = 0
			GlobalValues.energyActual += calculate_status(GlobalValues.energy,1,3)
			GlobalValues.lifeActual += calculate_status(GlobalValues.life,1,3)
		elif mainGun == "Varinha":
			GlobalValues.atkMainActual = 0
			GlobalValues.lifeActual += calculate_status(GlobalValues.life,1,3)
			GlobalValues.speedActual += calculate_status(GlobalValues.speed,1,2)
		elif mainGun == "Escudo":
			GlobalValues.atkMainActual = 0 
			GlobalValues.lifeActual -= calculate_status(GlobalValues.life,1,2) 
			GlobalValues.speedActual += calculate_status(GlobalValues.speed,1,4)
		elif mainGun == "Manopla":
			GlobalValues.atkMainActual = 0
			GlobalValues.speedActual -= calculate_status(GlobalValues.speed,1,2)
	elif typeAttribute == "ATKSec":
		if secGun == "Espada":
			GlobalValues.atkSecActual = 0
			GlobalValues.lifeActual -= calculate_status(GlobalValues.life,1,3)
		elif secGun == "Arco":
			GlobalValues.atkSecActual = 0
			GlobalValues.energyActual += calculate_status(GlobalValues.energy,1,3)
			GlobalValues.lifeActual += calculate_status(GlobalValues.life,1,3)
		elif secGun == "Varinha":
			GlobalValues.atkSecActual = 0
			GlobalValues.lifeActual += calculate_status(GlobalValues.life,1,3)
			GlobalValues.speedActual += calculate_status(GlobalValues.speed,1,2)
		elif secGun == "Escudo":
			GlobalValues.atkSecActual = 0
			GlobalValues.lifeActual -= calculate_status(GlobalValues.life,1,2) 
			GlobalValues.speedActual += calculate_status(GlobalValues.speed,1,4)
		elif secGun == "Manopla":
			GlobalValues.atkSecActual = 0
			GlobalValues.speedActual -= calculate_status(GlobalValues.speed,1,2)
			
	change_UI_status()

func reset_attributes():
	GlobalValues.atkMainActual = 0
	GlobalValues.atkSecActual = 0
	GlobalValues.lifeActual = 0
	GlobalValues.speedActual = 0
	GlobalValues.energyActual = 0
	change_UI_status()

func change_UI_status():
	$Inventory/BG_Inventory/Info_BG/Status_Container/Speed_Run/BG_Bar/Bar.value = GlobalValues.speedActual
	$Inventory/BG_Inventory/Info_BG/Status_Container/Life/BG_Bar/Bar.value = $Status/Life_Bar.max_value
	$Inventory/BG_Inventory/Info_BG/Status_Container/Energy/BG_Bar/Bar.value = $Status/Energy_Bar.max_value
	$Inventory/BG_Inventory/Info_BG/Status_Container/Speed_Run/BG_Bar/Bar.value = $States/Move.speedRun
	$Inventory/BG_Inventory/Info_BG/Status_Container/ATK_Main/BG_Bar/Bar.value = GlobalValues.atkMainActual
	$Inventory/BG_Inventory/Info_BG/Status_Container/ATK_Sec/BG_Bar/Bar.value = GlobalValues.atkSecActual
	#------
	if GlobalValues.lifeActual > 0:
		$Status/Life_Bar.max_value = GlobalValues.lifeActual
		$Inventory/BG_Inventory/Info_BG/Status_Container/Life/ID_Bar.text = "Saude + " + str(GlobalValues.lifeActual)
	else:
		$Status/Life_Bar.max_value = GlobalValues.life
		$Inventory/BG_Inventory/Info_BG/Status_Container/Life/ID_Bar.text = "Saude = " + str(GlobalValues.life)
	
	if GlobalValues.energyActual > 0:
		$Status/Energy_Bar.max_value = GlobalValues.energyActual
		$Inventory/BG_Inventory/Info_BG/Status_Container/Energy/ID_Bar.text = "Energia + " + str(GlobalValues.energyActual)
	else:
		$Status/Energy_Bar.max_value = GlobalValues.energy
		$Inventory/BG_Inventory/Info_BG/Status_Container/Energy/ID_Bar.text = "Energia = " + str(GlobalValues.energy)
		
	if GlobalValues.speedActual > 0:
		$States/Move.speedRun = GlobalValues.speedActual
		$Inventory/BG_Inventory/Info_BG/Status_Container/Speed_Run/BG_Bar/Bar.value = GlobalValues.speedActual
		$Inventory/BG_Inventory/Info_BG/Status_Container/Speed_Run/ID_Bar.text = "Vel. + " + str(GlobalValues.speedActual)
	else:
		$States/Move.speedRun = GlobalValues.speed
		$Inventory/BG_Inventory/Info_BG/Status_Container/Speed_Run/BG_Bar/Bar.value = GlobalValues.speed
		$Inventory/BG_Inventory/Info_BG/Status_Container/Speed_Run/ID_Bar.text = "Vel. + " + str(GlobalValues.speed)
	
	if GlobalValues.atkMainActual > 0:
		$Inventory/BG_Inventory/Info_BG/Status_Container/ATK_Main/ID_Bar.text = "Ataque Primario + " + str(GlobalValues.atkMainActual)
	else:
		$Inventory/BG_Inventory/Info_BG/Status_Container/ATK_Main/ID_Bar.text = "Ataque Primario " + str(GlobalValues.atkMainActual)
	
	if GlobalValues.atkSecActual > 0:
		$Inventory/BG_Inventory/Info_BG/Status_Container/ATK_Sec/ID_Bar.text = "Ataque Sec + " + str(GlobalValues.atkSecActual)
	else:
		$Inventory/BG_Inventory/Info_BG/Status_Container/ATK_Sec/ID_Bar.text = "Ataque Sec " + str(GlobalValues.atkSecActual)
#--------------------------- Vida
	if $Status/Life_Bar.max_value >= 100:
		$Inventory/BG_Inventory/Info_BG/Status_Container/Life/BG_Bar/Bar.self_modulate = Color.red
	else:
		$Inventory/BG_Inventory/Info_BG/Status_Container/Life/BG_Bar/Bar.self_modulate = Color.white
#--------------------------- Energia
	if $Status/Energy_Bar.max_value >= 100:
		$Inventory/BG_Inventory/Info_BG/Status_Container/Energy/BG_Bar/Bar.self_modulate = Color.red
	else:
		$Inventory/BG_Inventory/Info_BG/Status_Container/Energy/BG_Bar/Bar.self_modulate = Color.white
#--------------------------- Correr
	if $States/Move.speedRun >= 100:
		$Inventory/BG_Inventory/Info_BG/Status_Container/Speed_Run/ID_Bar.self_modulate = Color.red
	else:
		$Inventory/BG_Inventory/Info_BG/Status_Container/Speed_Run/ID_Bar.self_modulate = Color.white
#--------------------------- Primario Atk
	if $Inventory/BG_Inventory/Info_BG/Status_Container/ATK_Main/BG_Bar/Bar.value >= 100:
		$Inventory/BG_Inventory/Info_BG/Status_Container/ATK_Main/BG_Bar/Bar.self_modulate = Color.red
	else:
		$Inventory/BG_Inventory/Info_BG/Status_Container/ATK_Main/BG_Bar/Bar.self_modulate = Color.white
#--------------------------- Sec. Atk
	if $Inventory/BG_Inventory/Info_BG/Status_Container/ATK_Sec/BG_Bar/Bar.value >= 100:
		$Inventory/BG_Inventory/Info_BG/Status_Container/ATK_Sec/BG_Bar/Bar.self_modulate = Color.red
	else:
		$Inventory/BG_Inventory/Info_BG/Status_Container/ATK_Sec/BG_Bar/Bar.self_modulate = Color.white

func change_only_bar_value(bar):
	if bar == "Life":
		$Status/Life_Bar.value = GlobalValues.lifeActual
	elif bar == "Energy":
		print("energ atual = " + str(GlobalValues.energyActual))
		$Status/Energy_Bar.value = GlobalValues.energyActual

func calculate_status(baseValue,numerator,denominator):
	return (baseValue/denominator) * numerator

func cinematic_mode(status):
	if status == "started":
		for i in nodesToHide.size():
			get_node(nodesToHide[i]).hide()
	else:
		for i in nodesToHide.size():
			get_node(nodesToHide[i]).show()
