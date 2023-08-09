extends CanvasLayer

# Texto a ser mostrado na tela
var txt : String

func _ready():
	get_tree().paused = true
	$BG/Desc.text = txt

func _on_BT_Continue_pressed():
	get_tree().paused = false
	queue_free()
