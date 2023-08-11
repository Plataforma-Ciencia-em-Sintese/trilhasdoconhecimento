extends CanvasLayer

onready var invent : Node = get_tree().get_nodes_in_group("Inventory")[0]
onready var player : Node = get_tree().get_nodes_in_group("Player")[0]
var progressiveDamage : bool = false

func _ready():
	# Conecta ao signal do script global do xp
	GlobalXp.connect("xp",self,"set_xp")
	GlobalAdmLifeEnergy.connect("setLife",self,"set_life")
	GlobalAdmLifeEnergy.connect("setEnergy",self,"set_energy")
	$XP_Bar/XP_Txt.text = "LVL | " + str(GlobalValues.levelPlayer)

# Preseta a vida do jogador vindo de danos em geral
func set_life(value):
	$Life_Bar.value += value
	if $Life_Bar.value <= 0:
		player.get_node("States/Move").hide()
		player.get_node("States/Talking").show()
		player.get_node("States/Battling").end_fight()
		player.get_node("States/Battling").hide()
		player.hide()

# Preseta a energia do jogador vindo de consumiveis
func set_energy(value):
	$Energy_Bar.value += value

# Seta o xp geral 
# Signal vem do script global chamado por qlqr objeto
func set_xp(value):
	var remain = GlobalValues.xpActual + value
	if remain > $XP_Bar.max_value:
		var result = remain - $XP_Bar.max_value
		GlobalValues.xpActual = result
		GlobalValues.levelPlayer += 1
		GlobalXp.unlock_skill()
		$XP_Bar.value = result
		$XP_Bar/XP_Txt.text = "LVL | " + str(GlobalValues.levelPlayer)
	elif remain == $XP_Bar.max_value:
		GlobalValues.xpActual = 0
		GlobalValues.levelPlayer += 1
		GlobalXp.unlock_skill()
		$XP_Bar.value = 0
		$XP_Bar/XP_Txt.text = "LVL | " + str(GlobalValues.levelPlayer)
	elif remain < $XP_Bar.max_value:
		GlobalValues.xpActual += value
		$XP_Bar.value = GlobalValues.xpActual
	
	print("lvl - " + str(GlobalValues.levelPlayer))
	print("xp - " + str(GlobalValues.xpActual))
