extends Control

var player_Ariel= true
export (PackedScene) var Ariel


func _on_Player_Ariel_pressed():
	var new_Ariel = Ariel.instance()
	#get_tree().get_nodes_in_group("nivel")[0].add_child(new_Ariel)
	#new_Ariel.translation = get_node("SpawnPlayer").global_transform.origin
# Play
	var _play: bool = get_tree().change_scene("res://Scenes/Sci Fi Room/Debug_Room.tscn")


func _on_Player_Bento_pressed():
# Play
	var _play: bool = get_tree().change_scene("res://Scenes/Sci Fi Room/Debug_Room.tscn")

func _on_Player_Caio_pressed():
# Play
	var _play: bool = get_tree().change_scene("res://Scenes/Sci Fi Room/Debug_Room.tscn")

func _on_Player_Clara_pressed():
# Play
	var _play: bool = get_tree().change_scene("res://Scenes/Sci Fi Room/Debug_Room.tscn")

func _on_Player_Yara_pressed():
# Play
	var _play: bool = get_tree().change_scene("res://Scenes/Sci Fi Room/Debug_Room.tscn")
