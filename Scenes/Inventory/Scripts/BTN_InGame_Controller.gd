extends Button

# Recebe a resource com valores desse botao
var buttonResource : Resource
# Se for skill qual o nivel (1, 2 ou 3)
var level : int
# Referencia desse botao no invetario caso ele seja um consumivel
var btnRefConsum : Node

# Identifica o player e o pointer para executar as acoes
onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var pointer = get_tree().get_nodes_in_group("Pointer")[0]

func _ready():
	# Preseta o icone do botao
	icon = buttonResource.icon

func _on_BTN_In_Game_pressed():
	# Se esse botao e uma arma, chama a funcao de troca arma do player
	if buttonResource.type == "Weapon":
		player.change_weapons(buttonResource.name)
	
	# O outInterface faz o player nao andar quando ele estiver tocando em um botao na tela
	pointer.outInterface = false

func _on_BTN_In_Game_mouse_entered():
	pointer.outInterface = false

func _on_BTN_In_Game_mouse_exited():
	pointer.outInterface = true
