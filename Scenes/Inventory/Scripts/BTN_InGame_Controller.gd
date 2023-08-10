extends Button

# Recebe a resource com valores desse botao
var buttonResource : Resource
# Se for skill qual o nivel (1, 2 ou 3)
var level : int
# Referencia desse botao no invetario caso ele seja um consumivel
var btnRefConsum : Node
# Referencia desse botao no invetario caso ele seja uma skill
var btnRefSkill : Node

# Identifica o player e o pointer para executar as acoes
onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var pointer = get_tree().get_nodes_in_group("Pointer")[0]

func _ready():
	# Preseta o icone do botao
	icon = buttonResource.icon
	
	if buttonResource.type == "Skill":
		$BG_Quant.hide()
		GlobalXp.connect("lvl",self,"unlock_skill_weapon")
		if GlobalValues.levelPlayer < buttonResource.levelToUnlock and !buttonResource.unlocked:
			hide()
	elif buttonResource.type == "Consum":
		GlobalAdmItens.connect("consumGived",self,"update_consum_text")
		$BG_Quant.show()
		$BG_Quant/Quant_Txt.text = "X" + str(buttonResource.quant)
	else:
		$BG_Quant.hide()

func _on_BTN_In_Game_pressed():
	# Se esse botao e uma arma, chama a funcao de troca arma do player
	if buttonResource.type == "Weapon":
		player.change_weapons(buttonResource.name)
	elif buttonResource.type == "Consum":
		if buttonResource.quant > 0:
			buttonResource.quant -= 1
			$BG_Quant/Quant_Txt.text = "X" + str(buttonResource.quant)
			if buttonResource.quant <= 0:
				btnRefConsum.hide()
				queue_free()

	# O outInterface faz o player nao andar quando ele estiver tocando em um botao na tela
	pointer.outInterface = false

func _on_BTN_In_Game_mouse_entered():
	pointer.outInterface = false

func _on_BTN_In_Game_mouse_exited():
	pointer.outInterface = true

func unlock_skill_weapon():
	if GlobalValues.levelPlayer >= buttonResource.levelToUnlock:
		show()
		btnRefSkill.show()
		print("desbloqueado skill " + buttonResource.name)

func update_consum_text():
	# O signal do adm de itens chama essa funcao qunado coletado algum item consumivel
	$BG_Quant/Quant_Txt.text = "X" + str(buttonResource.quant)
