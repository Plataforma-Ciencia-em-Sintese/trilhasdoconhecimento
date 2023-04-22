extends CanvasLayer

export (NodePath) var camera
export (Array,String) var itensATK
export (Array,String) var itensConsum
export var weaponActual = "Wand"
onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	camera = get_node(camera)
	$Mouse_Block.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	var inventBTN = load("res://Scenes/Inventory/ItemIvent_BTN.tscn")
	for i in GlobalValues.atkPassivesReward.size():
		var ATKBtn = inventBTN.instance()
		ATKBtn.iconITN = load(GlobalValues.atkPassivesReward.values()[i][2])
		ATKBtn.descITN = GlobalValues.atkPassivesReward.values()[i][3]
		ATKBtn.nameITN = GlobalValues.atkPassivesReward.keys()[i]
		ATKBtn.typeITN = "ATK"
		$BG_Inventory/Title_Combate/Combat_Itens.add_child(ATKBtn)
	for i in GlobalValues.consumRewards.size():
		var consumBtn = inventBTN.instance()
		consumBtn.iconITN = load(GlobalValues.consumRewards.values()[i][1])
		consumBtn.descITN = GlobalValues.consumRewards.values()[i][2]
		consumBtn.nameITN = GlobalValues.consumRewards.keys()[i]
		consumBtn.typeITN = "Consum"
		$BG_Inventory/Title_Consums/Consum_Itens.add_child(consumBtn)
		
func _on_BT_Inventario_pressed():
	$Mouse_Block.mouse_filter = Control.MOUSE_FILTER_STOP
	$BT_Inventario.hide()
	$BG_Inventory.show()
	get_parent().get_node("Pause").hide()
	get_parent().get_node("Life").hide()
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
	get_parent().get_node("Pause").show()
	get_parent().get_node("Life").show()
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
	for i in itensConsum.size():
		if GlobalValues.consumRewards.has(itensConsum[i]):
			GlobalValues.consumItens[itensConsum[i]] = GlobalValues.consumRewards.get(itensConsum[i])
	
	player.mainGun = weaponActual
	player.change_weapons()
	player.create_btns_battle("ATK")
	player.create_btns_battle("Consum")

func delete_dictionaty():
	for i in GlobalValues.atkItens.size():
		GlobalValues.atkItens.clear()
	for i in GlobalValues.consumItens.size():
		GlobalValues.consumItens.clear()

func _on_Clean_Consum_pressed():
	itensConsum.resize(0)
	for i in GlobalValues.consumItens.size():
		GlobalValues.consumItens.clear()
	for i in $BG_Inventory/Equiped_BG/Title_Consums/Consum_Repo.get_child_count():
		$BG_Inventory/Equiped_BG/Title_Consums/Consum_Repo.get_child(i).queue_free()

func _on_Clean_Combat_pressed():
	itensATK.resize(0)
	for i in GlobalValues.atkItens.size():
		GlobalValues.atkItens.clear()
	for i in $BG_Inventory/Equiped_BG/Title_Combat/Combat_Repo.get_child_count():
		$BG_Inventory/Equiped_BG/Title_Combat/Combat_Repo.get_child(i).queue_free()
