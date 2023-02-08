extends Control

var Player_Ariel = "res://Scenes/Character/Character_Official.tscn"
var Player_Bento = "res://Scenes/Character/Character_Official_2.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func goToScene():
	get_tree().change_scene("res://Scenes/Sci Fi Room/Debug_Room.tscn")

func _on_Player_Ariel_pressed():
	#Global.playerDir = Player_Ariel
	goToScene()

func _on_Player_Bento_pressed():
	#Global.playerDir = Player_Bento
	goToScene()

func _on_Player_Caio_pressed():
	pass # Replace with function body.

func _on_Player_Clara_pressed():
	pass # Replace with function body.

func _on_Player_Yara_pressed():
	pass # Replace with function body.
