extends Button

var weapon = ""
onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var pointer = get_tree().get_nodes_in_group("Pointer")[0]

func _on_WeaponBTN_pressed():
	player.change_weapons_in_game(weapon)
	pointer.outInterface = false
	
func _on_WeaponBTN_mouse_entered():
	pointer.outInterface = false
	
func _on_WeaponBTN_mouse_exited():
	pointer.outInterface = true
