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
	$BG_Inventory/Info_BG/Name_Char.text = GlobalValues.nameChar
	camera = get_node(camera)
	$Mouse_Block.mouse_filter = Control.MOUSE_FILTER_IGNORE
	weaponActual = player.mainGun
	weaponSecond = player.secGun
	var inventBTN = load("res://Scenes/Inventory/ItemIvent_BTN.tscn")
#	for i in GlobalValues.atkPassivesReward.size():
#		var ATKBtn = inventBTN.instance()
#		ATKBtn.iconITN = load(GlobalValues.atkPassivesReward.values()[i][1])
#		ATKBtn.descITN = GlobalValues.atkPassivesReward.values()[i][2]
#		ATKBtn.nameITN = GlobalValues.atkPassivesReward.keys()[i]
#		ATKBtn.typeITN = "ATK"
#		$BG_Inventory/Title_Combate/Combat_Itens.add_child(ATKBtn)

	var weaponIconInvent = inventBTN.instance()
	var weaponIconStage = inventBTN.instance()
	weaponIconInvent.iconITN = load(GlobalValues.weapons[player.mainGun][0])
	weaponIconStage.iconITN = load(GlobalValues.weapons[player.mainGun][0])
	weaponIconInvent.disabled = true
	weaponIconStage.disabled = true
	$BG_Inventory/Equiped_BG/Title_Weapons/Weapons_Repo.add_child(weaponIconInvent)
	player.get_node("Battle_UI/Container_Weapon_Main/Weapon_Main").add_child(weaponIconStage)
	
	var weaponIconInventSec = inventBTN.instance()
	var weaponIconStageSec = inventBTN.instance()
	weaponIconInventSec.iconITN = load(GlobalValues.weapons[player.secGun][0])
	weaponIconStageSec.iconITN = load(GlobalValues.weapons[player.secGun][0])
	weaponIconInventSec.disabled = true
	weaponIconStageSec.disabled = true
	$BG_Inventory/Equiped_BG/Title_Weapons_Sec/Weapons_Sec_Repo.add_child(weaponIconInventSec)
	player.get_node("Battle_UI/Container_Weapon_Sec/Weapon_Sec").add_child(weaponIconStageSec)

	var ATKBtn = inventBTN.instance()
	for i in GlobalValues.weapons[player.mainGun][2].size():
#		if GlobalValues.weapons[player.mainGun][2][i][1] >= GlobalValues.levelPlayer:
		itensATK.append(GlobalValues.weapons[player.mainGun][2][i][0])
		ATKBtn.iconITN = load(GlobalValues.atkPassivesReward[GlobalValues.weapons[player.mainGun][2][i][0]][1])
#			break
#		$BG_Inventory/Equiped_BG/Title_Combat/Combat_Repo.add_child(ATKBtn)
		ATKBtn.disabled = true
	for i in itensATK.size():
		if GlobalValues.atkPassivesReward.has(itensATK[i]):
			GlobalValues.atkItens[itensATK[i]] = GlobalValues.atkPassivesReward.get(itensATK[i])
#------------------------------------------------
	for i in GlobalValues.weapons[player.secGun][2].size():
#		if GlobalValues.weapons[player.mainGun][2][i][1] >= GlobalValues.levelPlayer:
		itensATKSec.append(GlobalValues.weapons[player.secGun][2][i][0])
		ATKBtn.iconITN = load(GlobalValues.atkPassivesReward[GlobalValues.weapons[player.secGun][2][i][0]][1])
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
		var weaponsBtn = inventBTN.instance()
		weaponsBtn.iconITN = load(GlobalValues.weapons.values()[i][0])
		weaponsBtn.descITN = GlobalValues.weapons.values()[i][1]
		weaponsBtn.nameITN = GlobalValues.weapons.keys()[i]
		weaponsBtn.typeITN = "Weapons"
		$BG_Inventory/Title_Weapons/Weapons_Itens.add_child(weaponsBtn)
		
func _on_BT_Inventario_pressed():
	$Mouse_Block.mouse_filter = Control.MOUSE_FILTER_STOP
	$BT_Inventario.hide()
	$BG_Inventory.show()
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
	
	#checar novamente os itens consumiveis quantidade
	# valor dos itens vem do dicionario de recompensas, nao do que ta equipado
	itensConsum.resize(0)
	for i in $BG_Inventory/Title_Consums/Consum_Itens.get_child_count():
		$BG_Inventory/Title_Consums/Consum_Itens.get_child(i).queue_free()
	
	var inventBTN = load("res://Scenes/Inventory/ItemIvent_BTN.tscn")
	for i in GlobalValues.consumRewards.size():
		if GlobalValues.consumRewards.values()[i][3] > 0:
			var consumBtn = inventBTN.instance()
			consumBtn.name = GlobalValues.consumRewards.keys()[i]
			consumBtn.iconITN = load(GlobalValues.consumRewards.values()[i][1])
			consumBtn.descITN = GlobalValues.consumRewards.values()[i][2]
			consumBtn.nameITN = GlobalValues.consumRewards.keys()[i]
			consumBtn.typeITN = "Consum"
			$BG_Inventory/Title_Consums/Consum_Itens.add_child(consumBtn)
	#------
	
	if QuestManager.isInQuest:
		get_tree().get_nodes_in_group("BattleUI")[0].hide()
		get_tree().get_nodes_in_group("WhiteTransition")[0].get_node("Back").hide()
		get_tree().get_nodes_in_group("QuestManager")[0].get_node("Buttons_Diary").hide()
		
	get_tree().paused = true
	
func _on_BT_Close_pressed():
	$Mouse_Block.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$BT_Inventario.show()
	$BG_Inventory.hide()
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
	player.set_attributes()
	player.change_weapons()
	player.change_UI_status()
	player.create_btns_battle("ATK")
	player.create_btns_battle("Consum")
	
	if $BG_Inventory/Equiped_BG/Title_Passives/Passive_Repo.get_child_count() > 0:
		for i in $BG_Inventory/Equiped_BG/Title_Passives/Passive_Repo.get_child_count():
			player.choose_chip($BG_Inventory/Equiped_BG/Title_Passives/Passive_Repo.get_child(i).source)

func delete_dictionary_ATK():
	itensATK.resize(0)
	for i in GlobalValues.atkItens.size():
		GlobalValues.atkItens.clear()
#	for i in $BG_Inventory/Equiped_BG/Title_Combat/Combat_Repo.get_child_count():
#		$BG_Inventory/Equiped_BG/Title_Combat/Combat_Repo.get_child(i).queue_free()

func delete_dictionary_ATK_Sec():
	itensATKSec.resize(0)
	for i in GlobalValues.atkItensSec.size():
		GlobalValues.atkItensSec.clear()

func _on_Clean_Consum_pressed():
	itensConsum.resize(0)
	for i in GlobalValues.consumItens.size():
		GlobalValues.consumItens.clear()
	for i in $BG_Inventory/Equiped_BG/Title_Consums/Consum_Repo.get_child_count():
		$BG_Inventory/Equiped_BG/Title_Consums/Consum_Repo.get_child(i).queue_free()

func _on_Clean_Combat_pressed():
	delete_dictionary_ATK()

func _on_Clean_Passive_pressed():
	itensPassive.resize(0)
	player.choose_chip("")
	for i in GlobalValues.chipsItens.size():
		GlobalValues.chipsItens.clear()
	for i in $BG_Inventory/Equiped_BG/Title_Passives/Passive_Repo.get_child_count():
		$BG_Inventory/Equiped_BG/Title_Passives/Passive_Repo.get_child(i).queue_free()
		
func _on_Clean_Weapons_pressed():
	for i in $BG_Inventory/Equiped_BG/Title_Weapons/Weapons_Repo.get_child_count():
		$BG_Inventory/Equiped_BG/Title_Weapons/Weapons_Repo.get_child(i).queue_free()
		player.get_node("Battle_UI/Container_Weapon_Main/Weapon_Main").get_child(i).queue_free()
	weaponActual = ""
	$BG_Inventory/BT_Close.hide()
	delete_dictionary_ATK()
	change_battle_itens()
	
func _on_Clean_Weapons_Sec_pressed():
	for i in $BG_Inventory/Equiped_BG/Title_Weapons_Sec/Weapons_Sec_Repo.get_child_count():
		$BG_Inventory/Equiped_BG/Title_Weapons_Sec/Weapons_Sec_Repo.get_child(i).queue_free()
		player.get_node("Battle_UI/Container_Weapon_Sec/Weapon_Sec").get_child(i).queue_free()
	weaponSecond = ""
	delete_dictionary_ATK_Sec()
	change_battle_itens()
