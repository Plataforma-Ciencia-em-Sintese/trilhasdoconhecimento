extends Button

var typeITN
var nameITN
var descITN
var source
var equiped = false
var btnOnEquiped
var order = ""
onready var iconITN
onready var invent = get_tree().get_nodes_in_group("Inventory")[0]
onready var player = get_tree().get_nodes_in_group("Player")[0]
var marker
#var blockMouse = false

func _ready():
	icon = iconITN
	$UI/BG_Infos.hide()
	$Marker.hide()

func _on_ItemIvent_BTN_pressed():
#	if !blockMouse:
	marker =  get_tree().get_nodes_in_group("Marker")
	for i in marker.size():
		marker[i].hide()
		
	$Marker.show()

	invent.get_node("BG_Inventory/Description_Item").show()
	$UI/BG_Infos/Desc.text = descITN
	$UI/BG_Infos/Name.text = nameITN
	
	invent.get_node("BG_Inventory/Description_Item/BT_Equip").text = "Equipar"
	
	invent.get_node("BG_Inventory/Description_Item/Icon_Item").texture = iconITN
	invent.get_node("BG_Inventory/Description_Item/BT_Equip").iconITN = iconITN
	
	invent.get_node("BG_Inventory/Description_Item/Icon_Item/Item_Name").text = nameITN
	invent.get_node("BG_Inventory/Description_Item/BT_Equip").nameITN = nameITN
	
	invent.get_node("BG_Inventory/Description_Item/Icon_Item/Item_Desc").text = descITN
	invent.get_node("BG_Inventory/Description_Item/BT_Equip").descITN = descITN
	
	invent.get_node("BG_Inventory/Description_Item/BT_Equip").source = source
	invent.get_node("BG_Inventory/Description_Item/BT_Equip").typeITN = typeITN
	
	if typeITN == "Weapons":
		if equiped:
			invent.get_node("BG_Inventory/Description_Item/BT_Equip").disabled = false
		else:
			if player.mainGun != "" and player.secGun != "":
				invent.get_node("BG_Inventory/Description_Item/BT_Equip").disabled = true
			else:
				invent.get_node("BG_Inventory/Description_Item/BT_Equip").disabled = false
	elif typeITN == "Consum":
		if equiped:
			invent.get_node("BG_Inventory/Description_Item/BT_Equip").disabled = false
		else:
			if player.get_node("Inventory").itensConsum.size() < 2:
				invent.get_node("BG_Inventory/Description_Item/BT_Equip").disabled = false
			else:
				invent.get_node("BG_Inventory/Description_Item/BT_Equip").disabled = true
				
		invent.get_node("BG_Inventory/Description_Item/BT_Equip/Item_Quant").show()
		invent.get_node("BG_Inventory/Description_Item/BT_Equip/Item_Quant").text = "X " + str(GlobalValues.consumRewards[nameITN][3])
	else:
		if equiped:
			invent.get_node("BG_Inventory/Description_Item/BT_Equip").disabled = false
		else:
			if player.get_node("Inventory").itensPassive.size() < 1:
				invent.get_node("BG_Inventory/Description_Item/BT_Equip").disabled = false
			else:
				invent.get_node("BG_Inventory/Description_Item/BT_Equip").disabled = true
				
		invent.get_node("BG_Inventory/Description_Item/BT_Equip/Item_Quant").hide()
	
	if QuestManager.isInQuest:
		invent.change_battle_itens()
	
	invent.get_node("BG_Inventory/Description_Item/BT_Equip").btnOnEquip = self
	
	if equiped:
		invent.get_node("BG_Inventory/Description_Item/BT_Equip").text = "Deletar"
		invent.get_node("BG_Inventory/Description_Item/BT_Equip").btnOnEquip = btnOnEquiped
		invent.get_node("BG_Inventory/Description_Item/BT_Equip").deleteITN = true
		
		if typeITN != "Weapons":
			invent.get_node("BG_Inventory/Description_Item/BT_Equip").btnOnDestroy = self
		
#func _on_BT_Equip_pressed():
#	for i in GlobalValues.consumItens.size():
#		if GlobalValues.consumItens.keys()[i] == nameITN:
#			return
#
#	var btn = load("res://Scenes/Inventory/ItemIvent_BTN.tscn").instance()
#	btn.name = nameITN
#	btn.nameITN = nameITN
#	btn.descITN = descITN
#	btn.iconITN = iconITN
#	btn.source = source
#
#	if typeITN == "Consum":
#		invent.get_node("BG_Inventory/Equiped_BG/Title_Consums/Consum_Repo").add_child(btn)
#		invent.itensConsum.append(nameITN)
##	elif typeITN == "ATK":
##		invent.get_node("BG_Inventory/Equiped_BG/Title_Combat/Combat_Repo").add_child(btn)
##		invent.itensATK.append(nameITN)
#	elif typeITN == "Chips":
#		invent.get_node("BG_Inventory/Equiped_BG/Title_Passives/Passive_Repo").add_child(btn)
#		invent.itensPassive.append(nameITN)
##		invent.change_battle_itens()
#		player.choose_chip(btn.source)
#	elif typeITN == "Weapons":
#		if invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons/Weapons_Repo").get_child_count() > 0:
#			if invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons_Sec/Weapons_Sec_Repo").get_child_count() > 0:
#				invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons_Sec/Weapons_Sec_Repo").get_child(0).queue_free()
#				invent.player.get_node("Battle_UI/Container_Weapon_Sec/Weapon_Sec").get_child(0).queue_free()
#			invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons_Sec/Weapons_Sec_Repo").add_child(btn)
#
#			var weaponBTN = load("res://Scenes/Inventory/WeaponBTN.tscn").instance()
#			weaponBTN.weapon = nameITN
#			weaponBTN.icon = iconITN
#			invent.player.get_node("Battle_UI/Container_Weapon_Sec/Weapon_Sec").add_child(weaponBTN)
#
#			invent.itensPassive.append(nameITN)
#			btn.disabled = true
#			invent.weaponSecond = nameITN
#
#			invent.delete_dictionary_ATK_Sec()
#			var passive = load("res://Scenes/Inventory/ItemIvent_BTN.tscn").instance()
#			for i in GlobalValues.weapons[nameITN][2].size():
#	#			if GlobalValues.weapons[nameITN][2][i][1] >= GlobalValues.levelPlayer:
#				invent.itensATKSec.append(GlobalValues.weapons[nameITN][2][i])
#				passive.iconITN = load(GlobalValues.atkPassivesReward[GlobalValues.weapons[nameITN][2][i]][1])
#	#				break
#	#		if QuestManager.isInQuest:
#			invent.change_battle_itens()
#	#		invent.get_node("BG_Inventory/Equiped_BG/Title_Combat/Combat_Repo").add_child(passive)
#			passive.disabled = true
#		else:
#			invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons/Weapons_Repo").add_child(btn)
#
#			var weaponBTN = load("res://Scenes/Inventory/WeaponBTN.tscn").instance()
#			weaponBTN.weapon = nameITN
#			weaponBTN.icon = iconITN
#			invent.player.get_node("Battle_UI/Container_Weapon_Main/Weapon_Main").add_child(weaponBTN)
#
#			invent.itensPassive.append(nameITN)
#			btn.disabled = true
#			invent.weaponActual = nameITN
#			invent.get_node("BG_Inventory/BT_Close").show()
#
#			invent.delete_dictionary_ATK()
#			var passive = load("res://Scenes/Inventory/ItemIvent_BTN.tscn").instance()
#			for i in GlobalValues.weapons[nameITN][2].size():
#	#			if GlobalValues.weapons[nameITN][2][i][1] >= GlobalValues.levelPlayer:
#				invent.itensATK.append(GlobalValues.weapons[nameITN][2][i])
#				passive.iconITN = load(GlobalValues.atkPassivesReward[GlobalValues.weapons[nameITN][2][i]][1])
#	#				break
#	#		if QuestManager.isInQuest:
#			invent.change_battle_itens()
#	#		invent.get_node("BG_Inventory/Equiped_BG/Title_Combat/Combat_Repo").add_child(passive)
#			passive.disabled = true
#
#	btn.blockMouse = true
