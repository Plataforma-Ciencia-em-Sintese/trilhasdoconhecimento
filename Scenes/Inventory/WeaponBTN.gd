extends Button

var weapon = ""
onready var player = get_tree().get_nodes_in_group("Player")[0]

func _on_WeaponBTN_pressed():
	player.change_weapons_in_game(weapon)
	
