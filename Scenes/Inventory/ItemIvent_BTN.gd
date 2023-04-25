extends Button

var typeITN
var nameITN
var descITN
onready var iconITN
onready var invent = get_tree().get_nodes_in_group("Inventory")[0]
var blockMouse = false

func _ready():
	icon = iconITN
	$BT_Equip.hide()

func _on_ItemIvent_BTN_pressed():
	if !blockMouse:
		invent.get_node("BG_Inventory/Info_BG/Panel_Infos").texture = iconITN
		invent.get_node("BG_Inventory/Info_BG/Panel_Infos/Desc").text = descITN
		invent.get_node("BG_Inventory/Info_BG/Panel_Infos/Name").text = nameITN
		
		var allBTNS = get_tree().get_nodes_in_group("BTEquip")
		for i in allBTNS.size():
			get_tree().get_nodes_in_group("BTEquip")[i].hide()	
		$BT_Equip.show()
	
func _on_BT_Equip_pressed():
	var btn = load("res://Scenes/Inventory/ItemIvent_BTN.tscn").instance()
	btn.name = nameITN
	btn.nameITN = nameITN
	btn.descITN = descITN
	btn.iconITN = iconITN
	if typeITN == "Consum":
		invent.get_node("BG_Inventory/Equiped_BG/Title_Consums/Consum_Repo").add_child(btn)
		invent.itensConsum.append(nameITN)
	else:
		invent.get_node("BG_Inventory/Equiped_BG/Title_Combat/Combat_Repo").add_child(btn)
		invent.itensATK.append(nameITN)
	btn.blockMouse = true
	$BT_Equip.hide()
