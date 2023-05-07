extends Button

onready var rootPlayer = get_tree().get_nodes_in_group("Player")[0]
onready var pointer = get_tree().get_nodes_in_group("Pointer")[0]
onready var invent = get_tree().get_nodes_in_group("Inventory")[0]
var orbType = ""
var keyName = ""
var quant = 0

func _ready():
	$Quant.text = "X " + str(GlobalValues.consumItens[keyName][3])

func _on_Consumable_pressed():
	pointer.outInterface = false
	var spwn = load("res://Scenes/Consumables/Orb_Consumable.tscn").instance()
	rootPlayer.get_node("Base/Skeleton").add_child(spwn)
	spwn.orbType = orbType
	pointer.outInterface = true
	
	GlobalValues.consumRewards[keyName][3] -= 1
	$Quant.text = "X " + str(GlobalValues.consumRewards[keyName][3])
	if GlobalValues.consumRewards[keyName][3] <= 0:
		invent.get_node("BG_Inventory/Equiped_BG/Title_Consums/Consum_Repo").get_node(keyName).queue_free()
		GlobalValues.consumItens.erase(keyName)
		queue_free()

func _on_Consumable_mouse_entered():
	pointer.outInterface = false

func _on_Consumable_mouse_exited():
	pointer.outInterface = true
