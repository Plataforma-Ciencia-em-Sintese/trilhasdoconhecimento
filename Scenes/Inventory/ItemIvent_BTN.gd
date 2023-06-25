extends Button

var typeITN
var nameITN
var descITN
var source
onready var iconITN
onready var invent = get_tree().get_nodes_in_group("Inventory")[0]
onready var player = get_tree().get_nodes_in_group("Player")[0]
var blockMouse = false

func _ready():
	icon = iconITN
	$UI/BG_Infos.hide()

func _on_ItemIvent_BTN_pressed():
	if !blockMouse:
		$UI/BG_Infos/Desc.text = descITN
		$UI/BG_Infos/Name.text = nameITN
		
		var allBTNS = get_tree().get_nodes_in_group("BTEquip")
		for i in allBTNS.size():
			get_tree().get_nodes_in_group("BTEquip")[i].hide()
		$UI/BG_Infos.show()
		
		if typeITN == "Consum":
			$UI/BG_Infos/Quant_BG.show()
			$UI/BG_Infos/Quant_BG/Quant.text = "X " + str(GlobalValues.consumRewards[nameITN][3])
		else:
			$UI/BG_Infos/Quant_BG.hide()
		
		if QuestManager.isInQuest:
			invent.change_battle_itens()
	
func _on_BT_Equip_pressed():
	$UI/BG_Infos.hide()
	
	for i in GlobalValues.consumItens.size():
		if GlobalValues.consumItens.keys()[i] == nameITN:
			return
			
	var btn = load("res://Scenes/Inventory/ItemIvent_BTN.tscn").instance()
	btn.name = nameITN
	btn.nameITN = nameITN
	btn.descITN = descITN
	btn.iconITN = iconITN
	btn.source = source

	if typeITN == "Consum":
		invent.get_node("BG_Inventory/Equiped_BG/Title_Consums/Consum_Repo").add_child(btn)
		invent.itensConsum.append(nameITN)
#	elif typeITN == "ATK":
#		invent.get_node("BG_Inventory/Equiped_BG/Title_Combat/Combat_Repo").add_child(btn)
#		invent.itensATK.append(nameITN)
	elif typeITN == "Chips":
		invent.get_node("BG_Inventory/Equiped_BG/Title_Passives/Passive_Repo").add_child(btn)
		invent.itensPassive.append(nameITN)
#		invent.change_battle_itens()
		player.choose_chip(btn.source)
	elif typeITN == "Weapons":
		if invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons/Weapons_Repo").get_child_count() > 0:
			if invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons_Sec/Weapons_Sec_Repo").get_child_count() > 0:
				invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons_Sec/Weapons_Sec_Repo").get_child(0).queue_free()
				invent.player.get_node("Battle_UI/Container_Weapon_Sec/Weapon_Sec").get_child(0).queue_free()
			invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons_Sec/Weapons_Sec_Repo").add_child(btn)
			
			var weaponBTN = load("res://Scenes/Inventory/WeaponBTN.tscn").instance()
			weaponBTN.weapon = nameITN
			weaponBTN.icon = iconITN
			invent.player.get_node("Battle_UI/Container_Weapon_Sec/Weapon_Sec").add_child(weaponBTN)
			
			invent.itensPassive.append(nameITN)
			btn.disabled = true
			invent.weaponSecond = nameITN
			
			invent.delete_dictionary_ATK_Sec()
			var passive = load("res://Scenes/Inventory/ItemIvent_BTN.tscn").instance()
			for i in GlobalValues.weapons[nameITN][2].size():
	#			if GlobalValues.weapons[nameITN][2][i][1] >= GlobalValues.levelPlayer:
				invent.itensATKSec.append(GlobalValues.weapons[nameITN][2][i])
				passive.iconITN = load(GlobalValues.atkPassivesReward[GlobalValues.weapons[nameITN][2][i]][1])
	#				break
	#		if QuestManager.isInQuest:
			invent.change_battle_itens()
	#		invent.get_node("BG_Inventory/Equiped_BG/Title_Combat/Combat_Repo").add_child(passive)
			passive.disabled = true
		else:
			invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons/Weapons_Repo").add_child(btn)
			
			var weaponBTN = load("res://Scenes/Inventory/WeaponBTN.tscn").instance()
			weaponBTN.weapon = nameITN
			weaponBTN.icon = iconITN
			invent.player.get_node("Battle_UI/Container_Weapon_Main/Weapon_Main").add_child(weaponBTN)
			
			invent.itensPassive.append(nameITN)
			btn.disabled = true
			invent.weaponActual = nameITN
			invent.get_node("BG_Inventory/BT_Close").show()
		
			invent.delete_dictionary_ATK()
			var passive = load("res://Scenes/Inventory/ItemIvent_BTN.tscn").instance()
			for i in GlobalValues.weapons[nameITN][2].size():
	#			if GlobalValues.weapons[nameITN][2][i][1] >= GlobalValues.levelPlayer:
				invent.itensATK.append(GlobalValues.weapons[nameITN][2][i])
				passive.iconITN = load(GlobalValues.atkPassivesReward[GlobalValues.weapons[nameITN][2][i]][1])
	#				break
	#		if QuestManager.isInQuest:
			invent.change_battle_itens()
	#		invent.get_node("BG_Inventory/Equiped_BG/Title_Combat/Combat_Repo").add_child(passive)
			passive.disabled = true
	
	btn.blockMouse = true
