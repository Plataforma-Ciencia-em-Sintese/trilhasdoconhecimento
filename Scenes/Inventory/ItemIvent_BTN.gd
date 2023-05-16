extends Button

var typeITN
var nameITN
var descITN
var source
onready var iconITN
onready var invent = get_tree().get_nodes_in_group("Inventory")[0]
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
	elif typeITN == "Weapons":
		if invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons/Weapons_Repo").get_child_count() > 0:
			invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons/Weapons_Repo").get_child(0).queue_free()
		invent.get_node("BG_Inventory/Equiped_BG/Title_Weapons/Weapons_Repo").add_child(btn)
		invent.itensPassive.append(nameITN)
		btn.disabled = true
		invent.weaponActual = nameITN
		#----------------------------
		invent.delete_dictionary_ATK()
		var passive = load("res://Scenes/Inventory/ItemIvent_BTN.tscn").instance()
		for i in GlobalValues.weapons[nameITN][2].size():
			if GlobalValues.weapons[nameITN][2][i][1] >= GlobalValues.levelPlayer:
				invent.itensATK.append(GlobalValues.weapons[nameITN][2][i][0])
				passive.iconITN = load(GlobalValues.atkPassivesReward[GlobalValues.weapons[nameITN][2][i][0]][1])
				break
		invent.change_battle_itens()
		invent.get_node("BG_Inventory/Equiped_BG/Title_Combat/Combat_Repo").add_child(passive)
		passive.disabled = true
			
	btn.blockMouse = true
