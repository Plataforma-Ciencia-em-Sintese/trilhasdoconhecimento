extends CanvasLayer

export (NodePath) var camera
export (Array,Dictionary) var allItens
var itemScene = load("res://Scenes/Inventory/Item_BT.tscn")

func _ready():
	camera = get_node(camera)
	call_itens("Upgrades")
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_left"):
		for i in $BG_Inventory/GridContainer.get_children():
			i.queue_free()
		
		get_itens("Orbe de Conexão", "item adicionado", "res://icon.png", "Upgrades")
		
func _on_BT_Inventario_pressed():
	$BT_Inventario.hide()
	$BG_Inventory.show()
	get_parent().get_node("States/Move").hide()
	get_parent().get_node("States/Talking").show()
	camera.current = true
	get_tree().get_nodes_in_group("Camera")[0].current = false
	
	var pointer = get_tree().get_nodes_in_group("Pointer")[0]
	pointer.isStopped = true
	pointer.change_position()
	pointer.hide()
	
func _on_BT_Close_pressed():
	$BT_Inventario.show()
	$BG_Inventory.hide()
	get_parent().get_node("States/Move").show()
	get_parent().get_node("States/Talking").hide()
	camera.current = false
	get_tree().get_nodes_in_group("Camera")[0].current = true
	
	var pointer = get_tree().get_nodes_in_group("Pointer")[0]
	pointer.isStopped = false
	pointer.show()

func call_itens(type):
	if type == "Upgrades":
		for i in allItens[0].size():
			var newItn = itemScene.instance()
			$BG_Inventory/GridContainer.add_child(newItn)
			newItn.descr = allItens[0][allItens[0].keys()[i]][0]
			newItn.icon = load(allItens[0][allItens[0].keys()[i]][1])
			newItn.nameItem = allItens[0].keys()[i]
			newItn.type = type
	elif type == "Consumiveis":
		for i in allItens[1].size():
			var newItn = itemScene.instance()
			$BG_Inventory/GridContainer.add_child(newItn)
			newItn.descr = allItens[1][allItens[1].keys()[i]][0]
			newItn.icon = load(allItens[1][allItens[1].keys()[i]][1])
			newItn.nameItem = allItens[1].keys()[i]
			newItn.type = type

func get_itens(nameItem,descr,icon,type):
	if type == "Upgrades":
		allItens[0][nameItem] = [descr,icon]
		call_itens(type)
		
func _on_bt_item_down(item):
	for i in $BG_Inventory/GridContainer.get_children():
		i.queue_free()
	
	call_itens(item)
