extends Area

# ID do item
export (String, "Luneta","Lente") var item
# Valor da variavel
export var questVarValue = 1
# Signal para o contador
# Quem linka e o script global de quest
signal change_value(value)

func _ready():
	set_item(item)

func _on_Item_Quest_body_entered(body):
	if body.is_in_group("Player"):
		GlobalMusicPlayer.play_sound("play_one","event:/SFX/Menu Iventario/SelecionarItemConsumivel")
		emit_signal("change_value",questVarValue)
		queue_free()

func set_item(name):
	for i in get_child_count():
		if get_child(i).name != item and get_child(i).name != "CollisionShape":
			get_child(i).queue_free()
