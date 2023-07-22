extends Button

var typeITN
var nameITN
var descITN
var source
var equiped = false
var btnOnEquiped
var order = ""
var marker
var costPower
onready var iconITN
onready var invent = get_tree().get_nodes_in_group("Inventory")[0]
onready var player = get_tree().get_nodes_in_group("Player")[0]
#var blockMouse = false

func _ready():
	icon = iconITN
	$UI/BG_Infos.hide()
	$Marker.hide()

func _on_ItemIvent_BTN_pressed():
#	if !blockMouse:
	if !equiped:
		invent.get_node("BG_Inventory/Description_Item/BT_Equip").deleteITN = false
	else:
		invent.get_node("BG_Inventory/Description_Item/BT_Equip").deleteITN = true
	
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
	print("o tipo desse botao eh " + typeITN)
	print("ja o do botao equipar eh " + invent.get_node("BG_Inventory/Description_Item/BT_Equip").typeITN)
	
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
	elif typeITN == "Chips":
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
		
		print("esse botao equipado tem o type " + typeITN)
		
		if typeITN != "Weapons":
			invent.get_node("BG_Inventory/Description_Item/BT_Equip").btnOnDestroy = self
