extends Area

# ID do item
export (String, "Luneta","Lente","Telescopio","Consum") var item
# Velocidade de rotação
export (float) var speedRot = 1
# Valor da variavel
export var questVarValue = 1
# Signal para o contador
# Quem linka e o script global de quest
signal change_value(value)

export (bool) var giveConsumable
export (String, "Orbe_Energia","Orbe_Escudo") var consumType
export (int) var quant
var isInQuest : bool = false

func _ready():
	set_item(item)
	
func _physics_process(delta):
	rotate_y(speedRot * delta)

func _on_Item_Quest_body_entered(body):
	if body.is_in_group("Player"):
		GlobalMusicPlayer.play_sound("play_one","event:/SFX/Menu Iventario/SelecionarItemConsumivel")
		# Se estiver em quest, emite o signal pra mudar o valor da quest
		if isInQuest:
			emit_signal("change_value",questVarValue)
		# Se for consumivel, da a quantidade e atualiza o texto in game
		if giveConsumable:
			GlobalAdmItens.give_consums(consumType,quant)
		queue_free()

func set_item(name):
	for i in get_child_count():
		if get_child(i).name != item and get_child(i).name != "CollisionShape":
			get_child(i).queue_free()
