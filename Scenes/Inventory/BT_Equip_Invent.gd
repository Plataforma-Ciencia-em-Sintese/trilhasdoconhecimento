extends Button

var typeITN
var nameITN
var descITN
var source
var btnOnEquip
var btnOnDestroy
var deleteITN = false
onready var iconITN
onready var player = get_tree().get_nodes_in_group("Player")[0]

func _on_BT_Equip_pressed():
	if !deleteITN:
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
			owner.get_node("BG_Inventory/Title_Consum/Consum_Repo").add_child(btn)
			btn.typeITN = "Consum"
			owner.itensConsum.append(nameITN)
			GlobalValues.consumItens[nameITN] = GlobalValues.consumRewards.get(nameITN)
	#	elif typeITN == "ATK":
	#		invent.get_node("BG_Inventory/Equiped_BG/Title_Combat/Combat_Repo").add_child(btn)
	#		invent.itensATK.append(nameITN)
		elif typeITN == "Chips":
			owner.get_node("BG_Inventory/Title_Passive/Passive_Repo").add_child(btn)
			owner.itensPassive.append(nameITN)
			GlobalValues.chipsItens[nameITN] = GlobalValues.chipsRewards.get(nameITN)
	#		invent.change_battle_itens()
			player.choose_chip(btn.source)
		elif typeITN == "Weapons":
			if owner.get_node("BG_Inventory/Title_Weapon/Weapons_Repo").get_child_count() > 0:
				if owner.get_node("BG_Inventory/Title_Weapon/Weapons_Sec_Repo").get_child_count() > 0:
					owner.get_node("BG_Inventory/Title_Weapon/Weapons_Sec_Repo").get_child(0).queue_free()
					owner.player.get_node("Battle_UI/Container_Weapon_Sec/Weapon_Sec").get_child(0).queue_free()
				owner.get_node("BG_Inventory/Title_Weapon/Weapons_Sec_Repo").add_child(btn)
				
				var weaponBTN = load("res://Scenes/Inventory/WeaponBTN.tscn").instance()
				weaponBTN.weapon = nameITN
				weaponBTN.icon = iconITN
				owner.player.get_node("Battle_UI/Container_Weapon_Sec/Weapon_Sec").add_child(weaponBTN)
				
				owner.itensPassive.append(nameITN)
	#			btn.disabled = true
				btnOnEquip.order = "sec"
				owner.weaponSecond = nameITN
				
				owner.delete_dictionary_ATK_Sec()
				var passive = load("res://Scenes/Inventory/ItemIvent_BTN.tscn").instance()
				for i in GlobalValues.weapons[nameITN][2].size():
		#			if GlobalValues.weapons[nameITN][2][i][1] >= GlobalValues.levelPlayer:
					owner.itensATKSec.append(GlobalValues.weapons[nameITN][2][i])
					passive.iconITN = load(GlobalValues.atkPassivesReward[GlobalValues.weapons[nameITN][2][i]][1])
		#				break
		#		if QuestManager.isInQuest:
				owner.change_battle_itens()
		#		invent.get_node("BG_Inventory/Equiped_BG/Title_Combat/Combat_Repo").add_child(passive)
	#			passive.disabled = true
			else:
				owner.get_node("BG_Inventory/Title_Weapon/Weapons_Repo").add_child(btn)
				
				var weaponBTN = load("res://Scenes/Inventory/WeaponBTN.tscn").instance()
				weaponBTN.weapon = nameITN
				weaponBTN.icon = iconITN
				owner.player.get_node("Battle_UI/Container_Weapon_Main/Weapon_Main").add_child(weaponBTN)
				
				owner.itensPassive.append(nameITN)
	#			btn.disabled = true
				btnOnEquip.order = "main"
				owner.weaponActual = nameITN
				owner.get_node("BG_Inventory/BT_Close").show()
			
				owner.delete_dictionary_ATK()
				var passive = load("res://Scenes/Inventory/ItemIvent_BTN.tscn").instance()
				for i in GlobalValues.weapons[nameITN][2].size():
		#			if GlobalValues.weapons[nameITN][2][i][1] >= GlobalValues.levelPlayer:
					owner.itensATK.append(GlobalValues.weapons[nameITN][2][i])
					passive.iconITN = load(GlobalValues.atkPassivesReward[GlobalValues.weapons[nameITN][2][i]][1])
		#				break
		#		if QuestManager.isInQuest:
				owner.change_battle_itens()
		#		invent.get_node("BG_Inventory/Equiped_BG/Title_Combat/Combat_Repo").add_child(passive)
	#			passive.disabled = true
	
		btn.equiped = true
		btn.btnOnEquiped = btnOnEquip
		btnOnEquip.hide()
	else:
		if btnOnEquip.typeITN == "Weapons":
			if btnOnEquip.order == "sec":
				owner.clean_sec_weapon()
			else:
				owner.clean_main_weapon()
		elif btnOnEquip.typeITN == "Consum":
			owner.clean_consums(btnOnEquip.nameITN)
			btnOnDestroy.queue_free()
		else:
			owner.clean_passive(btnOnEquip.nameITN)
			btnOnDestroy.queue_free()
			
		btnOnEquip.show()
		deleteITN = false
	
	get_parent().hide()
