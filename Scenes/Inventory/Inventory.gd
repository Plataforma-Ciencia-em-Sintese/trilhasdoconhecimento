extends CanvasLayer

export (NodePath) var bigDesc
export (NodePath) var camera
export (Array,Dictionary) var allItens
var itemScene = load("res://Scenes/Attacks/Scripts/AttackBTN.gd")

func _ready():
	camera = get_node(camera)
	$Mouse_Block.mouse_filter = Control.MOUSE_FILTER_IGNORE
	call_itens("Upgrades")
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_left"):
		for i in $BG_Inventory/GridContainer.get_children():
			i.queue_free()
		
		get_itens("Orbe de Conexão", "item adicionado", "res://icon.png", "Upgrades")
		
func _on_BT_Inventario_pressed():
	$Mouse_Block.mouse_filter = Control.MOUSE_FILTER_STOP
	$BT_Inventario.hide()
	$BG_Inventory.show()
	get_parent().get_node("Pause").hide()
	get_parent().get_node("Life").hide()
	get_parent().get_node("States/Move").hide()
	get_parent().get_node("States/Talking").show()
	var cam = get_tree().get_nodes_in_group("Camera")[0]
	cam.anchorGeral = camera
	cam.geralLerp = true
	cam.projection = 0
	camera.current = true
	get_tree().get_nodes_in_group("Camera")[0].current = false
	
	var pointer = get_tree().get_nodes_in_group("Pointer")[0]
	pointer.isStopped = true
	pointer.change_position()
	pointer.hide()
	
func _on_BT_Close_pressed():
	$Mouse_Block.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$BT_Inventario.show()
	$BG_Inventory.hide()
	get_parent().get_node("Pause").show()
	get_parent().get_node("Life").show()
	get_parent().get_node("States/Move").show()
	get_parent().get_node("States/Talking").hide()
	var cam = get_tree().get_nodes_in_group("Camera")[0]
	cam.anchorGeral = ""
	cam.geralLerp = false
	cam.projection = 1
	camera.current = false
	get_tree().get_nodes_in_group("Camera")[0].current = true
	
	var pointer = get_tree().get_nodes_in_group("Pointer")[0]
	pointer.isStopped = false
	pointer.show()

func call_itens(type):
	if type == "Upgrades":
		var atkButtonScene = load("res://Scenes/Attacks/Button Commands/ATK.tscn")
		for i in GlobalValues.atkItens.size():
			var newItn = itemScene.instance()
			$BG_Inventory/GridContainer.add_child(newItn)
			newItn.descr = GlobalValues.atkItens.values()[i][3]
			newItn.icon = GlobalValues.atkItens.values()[i][3]
			newItn.nameItem = GlobalValues.atkItens.values()[i][3]
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


func _on_BT_Itens_button_down():
	pass # Replace with function body.
