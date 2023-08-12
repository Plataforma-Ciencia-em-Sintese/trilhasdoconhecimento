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
	if value < $Life_Bar.value:
		GlobalMusicPlayer.play_sound("play_one",owner.sfxResource.sfx["PersonagemDanoGeral"])
	
	if $Life_Bar.value <= 0:
		player.get_node("States/Move").hide()
		player.get_node("States/Talking").show()
		player.get_node("States/Battling").end_fight()
		player.get_node("States/Battling").hide()
		GlobalMusicPlayer.play_sound("play_one",owner.sfxResource.sfx["PersonagemMorreGeral"])
		player.hide()
		WhiteTransition.start_transition("fadein")
		yield(get_tree().create_timer(1),"timeout")
		get_tree().reload_current_scene()
		
		
# Preseta a energia do jogador vindo de consumiveis
func set_energy(value):
	$Energy_Bar.value += value

# Seta o xp geral 
# Signal vem do script global chamado por qlqr objeto
func set_xp(value):
	var remain = GlobalValues.xpActual + value
	if remain > $Hud_XP/XP_Bar.max_value:
		var result = remain - $Hud_XP/XP_Bar.max_value
		GlobalValues.xpActual = result
		GlobalValues.levelPlayer += 1
		GlobalXp.unlock_skill()
		$Hud_XP/XP_Bar.value = result
		$Hud_XP/XP_Bar/TXT_Level.text = "XP " + str(GlobalValues.levelPlayer)
	elif remain == $Hud_XP/XP_Bar.max_value:
		GlobalValues.xpActual = 0
		GlobalValues.levelPlayer += 1
		GlobalXp.unlock_skill()
		$Hud_XP/XP_Bar.value = 0
		$Hud_XP/XP_Bar/TXT_Level.text = "XP " + str(GlobalValues.levelPlayer)
	elif remain < $Hud_XP/XP_Bar.max_value:
		GlobalValues.xpActual += value
		$Hud_XP/XP_Bar.value = GlobalValues.xpActual
	
	print("lvl - " + str(GlobalValues.levelPlayer))
	print("xp - " + str(GlobalValues.xpActual))


func _on_BT_ShowXP_pressed():
	$Cartao_Hud.hide()
	$Hud_XP.show()

func _on_BT_HideXP_pressed():
	$Hud_XP.hide()
	$Cartao_Hud.show()
