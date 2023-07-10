extends CanvasLayer

export (NodePath) var camera
export (Array,String) var itensATK
export (Array,String) var itensATKSec
export (Array,String) var itensConsum
export (Array,String) var itensPassive
export var weaponActual = ""
export var weaponSecond = ""
onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	$BG_Inventory/Description_Item.hide()
	camera = get_node(camera)
	$Mouse_Block.mouse_filter = Control.MOUSE_FILTER_IGNORE
	weaponActual = player.mainGun
	weaponSecond = player.secGun
	var inventBTN = load("res://Scenes/Inventory/ItemIvent_BTN.tscn")
	var weaponBTN = load("res://Scenes/Inventory/WeaponBTN.tscn")

	var weaponIconStage = weaponBTN.instance()
	weaponIconStage.icon = load(GlobalValues.weapons[player.mainGun][0])
	weaponIconStage.weapon = player.mainGun
	player.get_node("Battle_UI/Container_Weapon_Main/Weapon_Main").add_child(weaponIconStage)
	
	var weaponIconStageSec = weaponBTN.instance()
	weaponIconStageSec.icon = load(GlobalValues.weapons[player.secGun][0])
	weaponIconStageSec.weapon = player.secGun
	player.get_node("Battle_UI/Container_Weapon_Sec/Weapon_Sec").add_child(weaponIconStageSec)

	var ATKBtn = inventBTN.instance()
	for i in GlobalValues.weapons[player.mainGun][2].size():
#		if GlobalValues.weapons[player.mainGun][2][i][1] >= GlobalValues.levelPlayer:
		itensATK.append(GlobalValues.weapons[player.mainGun][2][i])
		ATKBtn.iconITN = load(GlobalValues.atkPassivesReward[GlobalValues.weapons[player.mainGun][2][i]][1])
#			break
#		$BG_Inventory/Equiped_BG/Title_Combat/Combat_Repo.add_child(ATKBtn)
		ATKBtn.disabled = true
	for i in itensATK.size():
		if GlobalValues.atkPassivesReward.has(itensATK[i]):
			GlobalValues.atkItens[itensATK[i]] = GlobalValues.atkPassivesReward.get(itensATK[i])
#------------------------------------------------
	for i in GlobalValues.weapons[player.secGun][2].size():
#		if GlobalValues.weapons[player.mainGun][2][i][1] >= GlobalValues.levelPlayer:
		itensATKSec.append(GlobalValues.weapons[player.secGun][2][i])
		ATKBtn.iconITN = load(GlobalValues.atkPassivesReward[GlobalValues.weapons[player.secGun][2][i]][1])
#			break
#		$BG_Inventory/Equiped_BG/Title_Combat/Combat_Repo.add_child(ATKBtn)
		ATKBtn.disabled = true
	for i in itensATKSec.size():
		if GlobalValues.atkPassivesReward.has(itensATKSec[i]):
			GlobalValues.atkItensSec[itensATKSec[i]] = GlobalValues.atkPassivesReward.get(itensATKSec[i])
			
	player.create_btns_battle("ATK")
	
	for i in GlobalValues.consumRewards.size():
		if GlobalValues.consumRewards.values()[i][3] > 0:
			var consumBtn = inventBTN.instance()
			consumBtn.name = GlobalValues.consumRewards.keys()[i]
			consumBtn.iconITN = load(GlobalValues.consumRewards.values()[i][1])
			consumBtn.descITN = GlobalValues.consumRewards.values()[i][2]
			consumBtn.nameITN = GlobalValues.consumRewards.keys()[i]
			consumBtn.typeITN = "Consum"
			$BG_Inventory/Title_Consums/Consum_Itens.add_child(consumBtn)
			
	for i in GlobalValues.chipsRewards.size():
		var chipsBtn = inventBTN.instance()
		chipsBtn.iconITN = load(GlobalValues.chipsRewards.values()[i][1])
		chipsBtn.descITN = GlobalValues.chipsRewards.values()[i][2]
		chipsBtn.source = GlobalValues.chipsRewards.values()[i][0]
		chipsBtn.nameITN = GlobalValues.chipsRewards.keys()[i]
		chipsBtn.typeITN = "Chips"
		$BG_Inventory/Title_Passives/Passive_Itens.add_child(chipsBtn)
		
	for i in GlobalValues.weapons.size():
		if GlobalValues.weapons.keys()[i] == player.mainGun:
			var weaponsBtn = inventBTN.instance()
			var weaponsBtn2 = inventBTN.instance()
			
			weaponsBtn.hide()
			weaponsBtn.iconITN = load(GlobalValues.weapons[player.mainGun][0])
			weaponsBtn.nameITN = player.mainGun
			weaponsBtn.descITN = GlobalValues.weapons[player.mainGun][1]
			weaponsBtn.typeITN = "Weapons"
			weaponsBtn.order = "main"
			weaponsBtn.btnOnEquiped = weaponsBtn
			
			weaponsBtn2.iconITN = load(GlobalValues.weapons[player.mainGun][0])
			weaponsBtn2.nameITN = player.mainGun
			weaponsBtn2.descITN = GlobalValues.weapons[player.mainGun][1]
			weaponsBtn2.typeITN = "Weapons"
			weaponsBtn2.order = "main"
			weaponsBtn2.equiped = true
			weaponsBtn2.btnOnEquiped = weaponsBtn
			
			$BG_Inventory/Title_Weapon/Weapons_Repo.add_child(weaponsBtn2)
			$BG_Inventory/Title_Weapons/Weapons_Itens.add_child(weaponsBtn)
		elif GlobalValues.weapons.keys()[i] == player.secGun:
			var weaponsBtn = inventBTN.instance()
			var weaponsBtn2 = inventBTN.instance()
			
			weaponsBtn.hide()
			weaponsBtn.iconITN = load(GlobalValues.weapons[player.secGun][0])
			weaponsBtn.nameITN = player.secGun
			weaponsBtn.descITN = GlobalValues.weapons[player.secGun][1]
			weaponsBtn.typeITN = "Weapons"
			weaponsBtn.order = "sec"
			weaponsBtn.btnOnEquiped = weaponsBtn
			
			weaponsBtn2.iconITN = load(GlobalValues.weapons[player.secGun][0])
			weaponsBtn2.nameITN = player.secGun
			weaponsBtn2.descITN = GlobalValues.weapons[player.secGun][1]
			weaponsBtn2.typeITN = "Weapons"
			weaponsBtn2.order = "sec"
			weaponsBtn2.equiped = true
			weaponsBtn2.btnOnEquiped = weaponsBtn
			
			$BG_Inventory/Title_Weapon/Weapons_Sec_Repo.add_child(weaponsBtn2)
			$BG_Inventory/Title_Weapons/Weapons_Itens.add_child(weaponsBtn)
		else:
			var weaponsBtn = inventBTN.instance()
			weaponsBtn.iconITN = load(GlobalValues.weapons.values()[i][0])
			weaponsBtn.descITN = GlobalValues.weapons.values()[i][1]
			weaponsBtn.nameITN = GlobalValues.weapons.keys()[i]
			weaponsBtn.typeITN = "Weapons"
			$BG_Inventory/Title_Weapons/Weapons_Itens.add_child(weaponsBtn)
			
	#------------------------------------------------
	
func _on_BT_Inventario_pressed():
	$BT_Inventario.hide()
	$BG_Inventory.show()
	player.get_node("Battle_UI").hide()
	player.get_node("MiniMap_UI").hide()
	get_parent().get_node("Pause").hide()
	get_parent().get_node("Status").hide()
	get_parent().get_node("States/Move").hide()
	get_parent().get_node("States/Talking").show()
	var cam = get_tree().get_nodes_in_group("Camera")[0]
	cam.current = false
	player.get_node("Base/Cam_Invent").current = true
	player.get_node("Base/BG_Invent").show()

	var pointer = get_tree().get_nodes_in_group("Pointer")[0]
	pointer.isStopped = true
	pointer.change_position()
	pointer.hide()

	if QuestManager.isInQuest:
		get_tree().get_nodes_in_group("BattleUI")[0].hide()
		get_tree().get_nodes_in_group("WhiteTransition")[0].get_node("Back").hide()
		get_tree().get_nodes_in_group("QuestManager")[0].get_node("Buttons_Diary").hide()
		
	get_tree().paused = true
	
func _on_BT_Close_pressed():
	$Mouse_Block.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$BT_Inventario.show()
	$BG_Inventory.hide()
	player.get_node("Battle_UI").show()
	player.get_node("MiniMap_UI").show()
	get_parent().get_node("Pause").show()
	get_parent().get_node("Status").show()
	get_parent().get_node("States/Move").show()
	get_parent().get_node("States/Talking").hide()
	var cam = get_tree().get_nodes_in_group("Camera")[0]
	cam.current = true
	player.get_node("Base/Cam_Invent").current = false
	player.get_node("Base/BG_Invent").hide()

	var pointer = get_tree().get_nodes_in_group("Pointer")[0]
	pointer.isStopped = false
	pointer.show()
	
	if QuestManager.isInQuest:
		get_tree().get_nodes_in_group("BattleUI")[0].show()
		get_tree().get_nodes_in_group("WhiteTransition")[0].get_node("Back").show()
		get_tree().get_nodes_in_group("QuestManager")[0].get_node("Buttons_Diary").show()
	change_battle_itens()
	
	get_tree().paused = false

func change_battle_itens():
	#adiciona novos valores a eles
	for i in itensATK.size():
		if GlobalValues.atkPassivesReward.has(itensATK[i]):
			GlobalValues.atkItens[itensATK[i]] = GlobalValues.atkPassivesReward.get(itensATK[i])
	for i in itensATKSec.size():
		if GlobalValues.atkPassivesReward.has(itensATKSec[i]):
			GlobalValues.atkItensSec[itensATKSec[i]] = GlobalValues.atkPassivesReward.get(itensATKSec[i])
	for i in itensConsum.size():
		if GlobalValues.consumRewards.has(itensConsum[i]):
			GlobalValues.consumItens[itensConsum[i]] = GlobalValues.consumRewards.get(itensConsum[i])
	
	player.mainGun = weaponActual
	player.secGun = weaponSecond
	
#	if !gunMainEquiped:
#		player.set_attributes("ATKMain")
#		print(" main esta true")
#		gunMainEquiped = true
#
#	if !gunSecEquiped:
#		player.set_attributes("ATKSec")
#		print(" sec esta true")
#		gunSecEquiped = true

	player.change_weapons()
	player.create_btns_battle("ATK")
	player.create_btns_battle("Consum")

func delete_dictionary_ATK():
	itensATK.resize(0)
	for i in GlobalValues.atkItens.size():
		GlobalValues.atkItens.clear()

func delete_dictionary_ATK_Sec():
	itensATKSec.resize(0)
	for i in GlobalValues.atkItensSec.size():
		GlobalValues.atkItensSec.clear()

func clean_consums(nameConsum):
	itensConsum.resize(itensConsum.size()-1)
	GlobalValues.consumItens.erase(nameConsum)
	print(GlobalValues.consumItens.keys())

func _on_Clean_Combat_pressed():
	delete_dictionary_ATK()

func clean_passive(nameChip):
	itensPassive.resize(0)
	player.choose_chip(GlobalValues.chipsItens[nameChip][0],"Remove")
	GlobalValues.chipsItens.erase(nameChip)
	
func clean_main_weapon():
	for i in $BG_Inventory/Title_Weapon/Weapons_Repo.get_child_count():
		$BG_Inventory/Title_Weapon/Weapons_Repo.get_child(i).queue_free()
		player.get_node("Battle_UI/Container_Weapon_Main/Weapon_Main").get_child(i).queue_free()
	weaponActual = ""
	$BG_Inventory/BT_Close.hide()
	delete_dictionary_ATK()
	change_battle_itens()

func clean_sec_weapon():
	for i in $BG_Inventory/Title_Weapon/Weapons_Sec_Repo.get_child_count():
		$BG_Inventory/Title_Weapon/Weapons_Sec_Repo.get_child(i).queue_free()
		player.get_node("Battle_UI/Container_Weapon_Sec/Weapon_Sec").get_child(i).queue_free()
	weaponSecond = ""
	delete_dictionary_ATK_Sec()
	change_battle_itens()
