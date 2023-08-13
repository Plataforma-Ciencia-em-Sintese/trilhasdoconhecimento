extends CanvasLayer
	
func _ready():
	## Conecta ao signal global de quest para sempre ter a descriçao da quest atual
	GlobalQuest.connect("QuestInfos",self,"update_quest_main")
	## Esconde ou mostra o inventario de acordo com a fase Cyberspaço
	yield(get_tree().create_timer(0.5),"timeout")
	if GlobalQuest.localScene.stageName == "New_Debug_Room_2":
		$PanelTablet/background_Tablet/HBoxContainer/BT_Invent.hide()
		owner.get_node("Status/Cartao_Hud").show()
		owner.get_node("Status/background_Enegy").hide()
		owner.get_node("Status/Energy_Bar").hide()
		owner.get_node("Status/background_Life").hide()
		owner.get_node("Status/Life_Bar").hide()
	else:
		$PanelTablet/background_Tablet/HBoxContainer/BT_Invent.hide()
		owner.get_node("Status/Cartao_Hud").show()
		owner.get_node("Status/background_Enegy").show()
		owner.get_node("Status/Energy_Bar").show()
		owner.get_node("Status/background_Life").show()
		owner.get_node("Status/Life_Bar").show()

func _on_BT_tablet_pressed():
#	Fmod.play_one_shot("event:/SFX/Menu/AbrirMenuMissões", self)
	$BT_tablet.hide()
	$PanelTablet.show()
	get_tree().paused = true
	owner.get_node("Battle_UI").hide()
	owner.get_node("MiniMap_UI").hide()
	owner.get_node("Status").hide()
	owner.get_node("States/Move").hide()
	owner.get_node("States/Talking").show()
	
func _on_BT_Invent_pressed():
	owner.get_node("Inventory/BG_Inventory/Preview_Player_Viewport/Viewport/Char_Inventory").show()
	owner.get_node("Inventory/BG_Inventory").show()
	owner.get_node("States/Move").hide()
	owner.get_node("States/Talking").show()
	$PanelTablet.hide()
	
func _on_BT_Config_pressed():

	$Scenes/Control_Options/Panel_Options.show()
	$Scenes/Control_Options/Panel_Options/BT_ExitConfig.show()
	$PanelTablet.hide()
	

func _on_BT_Bestiario_pressed():

	$Scenes/BestiaryEnemy/Panel_Enemy.show()
	$Scenes/BestiaryEnemy/exit_Enemy.show()
	$PanelTablet.hide()

func _on_BT_Contatos_pressed():

	$Scenes/BestiaryNotables/Panel_Notables.show()
	$Scenes/BestiaryNotables/exit_Notables.show()
	$PanelTablet.hide()
	
func _on_BT_Trilhas_pressed():

	$Scenes/Trails/Panel_trails.show()
	$Scenes/Trails/exit_Trails.show()
	$PanelTablet.hide()
	
func _on_BT_ExitTablet_pressed():
	get_tree().paused = false
	$BT_tablet.show()
	$PanelTablet.hide()
	owner.get_node("Battle_UI").show()
	owner.get_node("MiniMap_UI").show()
	owner.get_node("Status").show()
	owner.get_node("States/Move").show()
	owner.get_node("States/Talking").hide()


func _on_BT_SairdoCS_pressed():
	pass # Replace with function body.


func _on_Panel_exit_pressed():
	get_tree().paused = false
	$BT_tablet.show()
	$PanelTablet.hide()
	owner.get_node("Battle_UI").show()
	owner.get_node("MiniMap_UI").show()
	owner.get_node("Status").show()
	owner.get_node("States/Move").show()
	owner.get_node("States/Talking").hide()

# Atualiza o texto da quest vinda do script global
func update_quest_main(title,desc):
	$PanelTablet/background_Tablet/Panel_Widget/BG_Widget/Panel_Main_Quest/Icon_Main_Quest/Main_Quest_Title.text = title
	$PanelTablet/background_Tablet/Panel_Widget/BG_Widget/Panel_Main_Quest/Main_Quest_Description.text = desc
