extends CanvasLayer

export (String) var backTo = ""
export (String) var skinType = ""
var sceneTeleporter = load("res://Scenes/Hologram Game/Teleport.tscn")
onready var pointer = get_tree().get_nodes_in_group("Pointer")[0]

func _on_Back_pressed():
	$AnimationPlayer.play("FadeIn")
	GlobalValues.backToScene = backTo
	GlobalValues.skinChar = skinType
	QuestManager.get_node("Buttons_Diary").hide()
	QuestManager.get_node("UI").hide()
	yield(get_tree().create_timer(2),"timeout")
	get_tree().change_scene("res://Scenes/Hologram Game/Teleport.tscn")
	
func _on_Back_mouse_entered():
	pointer.outInterface = false

func _on_Back_mouse_exited():
	pointer.outInterface = true

