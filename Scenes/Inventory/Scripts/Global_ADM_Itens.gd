extends Node

var consumItensPath : String = "res://Scenes/Inventory/Resource Inventory/Consums/"
onready var inventoryNode : Node
# Signal criado para informar a interface in game quando um consumivel foi pego e atualizar seu texto com quantidade
signal consumGived

#func _physics_process(delta):
#	if Input.is_action_just_pressed("ui_up"):
#		give_consums("Orbe_Energia",5)

func give_consums(name,quant):
	# Verifica no diretorio de consumiveis se existe algum por la
	# Aumenta a quantidade do item
	# Se sim manda o inventario ligar o consumivel caso ele exista no root consums
	var itemRes = get_files_in_directory(consumItensPath,name)[0]
	itemRes.quant += quant
	if inventoryNode.rootConsumsInventory.get_child_count() > 0:
		for i in inventoryNode.rootConsumsInventory.get_child_count():
			if inventoryNode.rootConsumsInventory.get_child(i).buttonResource.name == itemRes.name:
				inventoryNode.rootConsumsInventory.get_child(i).show()
	
	# Conectado ao botao in game se for consumivel
	emit_signal("consumGived")

func get_files_in_directory(path,name):
	# funcao que acessa a pasta especificada e coleta todos os .tres ja carregados
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif file.get_basename() == name:
			files.append(load(path + "/" + name + ".tres"))
	
	dir.list_dir_end()
	return files
