extends CanvasLayer

onready var invent = get_tree().get_nodes_in_group("Inventory")[0]
onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var atkButtons
var progressiveDamage = false

func _ready():
	$Hud_XP/XP_Bar.value = GlobalValues.xpActual
	$Hud_XP/XP_Bar/TXT_Level.text = "Level " + str(GlobalValues.levelPlayer)
	atkButtons = get_tree().get_nodes_in_group("ATKButton")

func grow_lvl():
	atkButtons = get_tree().get_nodes_in_group("ATKButton")
	GlobalValues.levelPlayer += 1
	$Hud_XP/XP_Bar/TXT_Level.text = "Level " + str(GlobalValues.levelPlayer)
	$Hud_XP/XP_Bar.value = 0
	for i in atkButtons.size():
		atkButtons[i].check_lvl()

func _on_XP_Bar_value_changed(value):
	GlobalValues.xpActual = value
	if value >= 100:
		grow_lvl()

func _physics_process(_delta):
	if Input.is_action_pressed("ui_select"):
		$Hud_XP/XP_Bar.value += 1
	
	if progressiveDamage:
		set_life(-2 * _delta)

func set_life(value):
	GlobalValues.lifeActual += value
	player.change_only_bar_value("Life")
	
	if $Life_Bar.value <= 0:
		player.get_node("States/Move").hide()
		player.get_node("States/Talking").show()
		player.get_node("States/Battling").end_fight()
		player.get_node("States/Battling").hide()
		player.hide()

func set_energy(value):
	GlobalValues.energyActual += value
	player.change_only_bar_value("Energy")


func _on_BT_HideXP_pressed():
	$Cartao_Hud.show()
	$Hud_XP.hide()


func _on_BT_ShowXP_pressed():
	$Hud_XP.show()
	$Cartao_Hud.hide()
