extends CanvasLayer

export (NodePath) var camera
export (Array,String) var itensATK
export (Array,String) var itensConsum
export var weaponActual = "Wand"
onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	camera = get_node(camera)
	$Mouse_Block.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_select"):
		change_battle_itens()
		
func _on_BT_Inventario_pressed():
	$Mouse_Block.mouse_filter = Control.MOUSE_FILTER_STOP
	$BT_Inventario.hide()
	$BG_Inventory.show()
	get_parent().get_node("Pause").hide()
	get_parent().get_node("Life").hide()
	get_parent().get_node("States/Move").hide()
	get_parent().get_node("States/Talking").show()
	var cam = get_tree().get_nodes_in_group("Camera")[0]
	cam.current = false
	player.get_node("Base/Cam_Invent").current = true
	player.get_node("Base/BG_Invent").show()
#	cam.anchorGeral = camera
#	cam.geralLerp = true
#	cam.projection = 0
	
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
	cam.current = true
	player.get_node("Base/Cam_Invent").current = false
	player.get_node("Base/BG_Invent").hide()
#	cam.anchorGeral = ""
#	cam.geralLerp = false
#	cam.projection = 1
	
	var pointer = get_tree().get_nodes_in_group("Pointer")[0]
	pointer.isStopped = false
	pointer.show()

func change_battle_itens():
	#limpa dicionarios atuais
	for i in GlobalValues.atkItens.size():
		GlobalValues.atkItens.clear()
	for i in GlobalValues.consumItens.size():
		GlobalValues.consumItens.clear()
		
	#adiciona novos valores a eles
	for i in itensATK.size():
		if GlobalValues.atkPassivesReward.has(itensATK[i]):
			GlobalValues.atkItens[itensATK[i]] = GlobalValues.atkPassivesReward.get(itensATK[i])
	for i in itensConsum.size():
		if GlobalValues.consumRewards.has(itensConsum[i]):
			GlobalValues.consumItens[itensConsum[i]] = GlobalValues.consumRewards.get(itensConsum[i])
	
	player.mainGun = weaponActual
	player.change_weapons()
	player.create_btns_battle("ATK")
	player.create_btns_battle("Consum")
