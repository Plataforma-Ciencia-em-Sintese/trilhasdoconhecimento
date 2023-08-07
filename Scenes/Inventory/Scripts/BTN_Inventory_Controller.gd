extends Button

# Cria um signal para quando qualquer botao for pressionado, o inventario altera os valores
signal change_item(itemType,res)
# Identifica a resource dos valores
var buttonResource : Resource
# Verifica se esse item ja esta equipado para ser deletado
var isEquiped : bool = false
# Se for uma arma, qual e a ordem (Main ou Secundario)
var weaponOrder : String
# Referencia o botao do inventario linkado
var btnLinked : Node
# Referencia o botao Consumivel do jogo linkado
var btnConsumLinked : Node

func _on_BTN_Inventory_pressed():
	# Manda o proprio botao pra saber quem e ele e se esta equipado ou nao
	emit_signal("change_item",self)
