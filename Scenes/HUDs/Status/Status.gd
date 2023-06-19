extends CanvasLayer

onready var invent = get_tree().get_nodes_in_group("Inventory")[0]
onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var atkButtons

func _ready():
	$XP_Bar.value = GlobalValues.xpActual
	$XP_Bar/TXT_Level.text = "Level " + str(GlobalValues.levelPlayer)
	atkButtons = get_tree().get_nodes_in_group("ATKButton")

func grow_lvl():
	atkButtons = get_tree().get_nodes_in_group("ATKButton")
	GlobalValues.levelPlayer += 1
	$XP_Bar/TXT_Level.text = "Level " + str(GlobalValues.levelPlayer)
	$XP_Bar.value = 0
	for i in atkButtons.size():
		atkButtons[i].check_lvl()
#	print(player.mainGun)
#
#	if GlobalValues.levelPlayer <= GlobalValues.weapons[player.mainGun][2].size():
#		invent.delete_dictionary_ATK()
#
#	for i in GlobalValues.weapons[player.mainGun][2].size():
#		if GlobalValues.weapons[player.mainGun][2][i][1] >= GlobalValues.levelPlayer:
#			invent.itensATK.append(GlobalValues.weapons[player.mainGun][2][i][0])
#			print(GlobalValues.weapons[player.mainGun][2][i][0])
#			break
#	invent.change_battle_itens()

func _on_XP_Bar_value_changed(value):
	GlobalValues.xpActual = value
	if value >= 100:
		grow_lvl()

func _physics_process(_delta):
	if Input.is_action_pressed("ui_select"):
		$XP_Bar.value += 1
	
