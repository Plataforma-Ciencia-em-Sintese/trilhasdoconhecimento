extends Button

onready var rootPlayer = get_tree().get_nodes_in_group("Player")[0]
onready var pointer = get_tree().get_nodes_in_group("Pointer")[0]
export var orbType = ""

func _on_Consumable_pressed():
	pointer.outInterface = false
	var spwn = load("res://Scenes/Consumables/Orb_Consumable.tscn").instance()
	rootPlayer.get_node("Base/Skeleton").add_child(spwn)
	spwn.orbType = orbType
	queue_free()
	pointer.outInterface = true

func _on_Consumable_mouse_entered():
	pointer.outInterface = false

func _on_Consumable_mouse_exited():
	pointer.outInterface = true
