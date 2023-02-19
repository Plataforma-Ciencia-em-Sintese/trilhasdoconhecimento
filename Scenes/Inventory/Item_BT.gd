extends Button

var nameItem: String
var type: String
var descr: String
var image: Texture

var descriptionBox
var bigDescriptionBox

func _ready():
	descriptionBox = get_tree().get_nodes_in_group("Description")[0]
	bigDescriptionBox = get_tree().get_nodes_in_group("BigDescription")[0]

func _on_Item_BT_mouse_entered():
	descriptionBox.show()
	bigDescriptionBox.show()
	
	descriptionBox.get_node("Txt").text = descr
	bigDescriptionBox.get_node("Title").text = nameItem
	bigDescriptionBox.get_node("Desc").text = descr
	bigDescriptionBox.get_node("Quant").text = "Sem valor ainda"

func _on_Item_BT_mouse_exited():
	descriptionBox.hide()
	bigDescriptionBox.hide()

func _on_Item_BT_pressed():
	descriptionBox.hide()
	bigDescriptionBox.hide()
	if type == "Upgrades":
		match nameItem:
			"Disruptor de sinal":
				get_tree().get_nodes_in_group("Inventory")[0].allItens[0].erase(nameItem)
				queue_free()
				print("disruptor")
			"Raio Imobilizador":
				get_tree().get_nodes_in_group("Inventory")[0].allItens[0].erase(nameItem)
				queue_free()
				print("raio")
			"Orbe de Conexão":
				get_tree().get_nodes_in_group("Inventory")[0].allItens[0].erase(nameItem)
				queue_free()
				print("conexao")
			"Orbe de Limpeza":
				get_tree().get_nodes_in_group("Inventory")[0].allItens[0].erase(nameItem)
				queue_free()
				print("limpeza")
	elif type == "Consumiveis":
		match nameItem:
			"Orbe de Conexão":
				get_tree().get_nodes_in_group("Inventory")[0].allItens[1].erase(nameItem)
				queue_free()
				print("conexao")
			"Orbe de Limpeza":
				get_tree().get_nodes_in_group("Inventory")[0].allItens[1].erase(nameItem)
				queue_free()
				print("limpeza")
