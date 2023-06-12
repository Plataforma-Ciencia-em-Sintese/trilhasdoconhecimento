extends CanvasLayer

#onready var player = get_tree().get_nodes_in_group("Player")[0]
export (Array,String) var itensConsum

func _ready():
	#$Scenes/Inventory/BT_Inventario.hide()

#func  _Control_back_entered():
#	get_parent().get_node("Pause").hide()
#	get_parent().get_node("Status").hide()
#	get_parent().get_node("States/Move").hide()
	#get_parent().get_node("States/Talking").show()
	#var pointer = get_tree().get_nodes_in_group("Pointer")[0]
	#pointer.isStopped = true
#	pointer.change_position()
#	pointer.hide()
	
	#get_tree().paused = true


#func  _Control_back_exited():
#	get_parent().get_node("Pause").show()
#	get_parent().get_node("Status").show()
	#get_parent().get_node("States/Move").show()
	#get_parent().get_node("States/Talking").hide()
	

	#var pointer = get_tree().get_nodes_in_group("Pointer")[0]
	#pointer.isStopped = false
	#pointer.show()
	
	if QuestManager.isInQuest:
		get_tree().get_nodes_in_group("BattleUI")[0].show()
		get_tree().get_nodes_in_group("WhiteTransition")[0].get_node("Back").show()
		get_tree().get_nodes_in_group("QuestManager")[0].get_node("Buttons_Diary").show()




func _on_BT_tablet_pressed():
	$BT_tablet.hide()
	$PanelTablet.show()
	#_Control_back_entered()


#func _on_BT_Inventory_pressed():
	#$Mouse_Block.mouse_filter = Control.MOUSE_FILTER_STOP
	
	#$PanelTablet/background_Tablet.hide()
	#$Scenes/Inventory/BG_Inventory/BT_Close.hide()
	#$Scenes/Inventory/BG_Inventory.show()
	#$Panel_Exit/BT_ExitInventory.show()
	
	#var cam = get_tree().get_nodes_in_group("Camera")[0]
	#cam.current = false
	#player.get_node("Base/Cam_Invent").current = true
	#player.get_node("Base/BG_Invent").show()
	#_Control_back_entered()


func _on_BT_Daily_pressed():
	$PanelTablet/background_Tablet.hide()
	$Scenes/Daily/Panel_Daily.show()
	$Panel_Exit/BT_ExitDaily.show()
	#_Control_back_entered()

func _on_BT_Inventory2_pressed():
	pass # Replace with function body.


func _on_BT_Enemy_pressed():
	$PanelTablet/background_Tablet.hide()
	$Scenes/BestiaryEnemy/Panel_Enemy.show()
	$Panel_Exit/BT_ExitEnemy.show()
	#_Control_back_entered()


func _on_BT_Trails_pressed():
	$PanelTablet/background_Tablet.hide()
	$Scenes/Trails/Panel_trails.show()
	$Panel_Exit/BT_ExitTrails.show()
	#_Control_back_entered()
	


func _on_BT_notables_pressed():
	$PanelTablet/background_Tablet.hide()
	$Scenes/BestiaryNotables/Panel_Notables.show()
	$Panel_Exit/BT_ExitNotable.show()
	#_Control_back_entered()



# Funções criadas para voltar para tela do Tablet

func _on_BT_ExitTablet_pressed():
	$PanelTablet.hide()
	$BT_tablet.show()
	get_tree().paused = false
	#_Control_back_exited()



func _on_BT_ExitEnemy_pressed():
	$Scenes/BestiaryEnemy/Panel_Enemy.hide()
	$Panel_Exit/BT_ExitEnemy.hide()
	$PanelTablet/background_Tablet.show()
	#_Control_back_exited()




func _on_BT_ExitNotable_pressed():
	$Scenes/BestiaryNotables/Panel_Notables.hide()
	$Panel_Exit/BT_ExitNotable.hide()
	$PanelTablet/background_Tablet.show()
	#_Control_back_exited()




func _on_BT_ExitDaily_pressed():
	$Scenes/Daily/Panel_Daily.hide()
	$Panel_Exit/BT_ExitDaily.hide()
	$PanelTablet/background_Tablet.show()
	#_Control_back_exited()



func _on_BT_ExitTrails_pressed():
	$Scenes/Trails/Panel_trails.hide()
	$Panel_Exit/BT_ExitTrails.hide()
	$PanelTablet/background_Tablet.show()
	#_Control_back_exited()



#func _on_BT_ExitInventory_pressed():
	#$Scenes/Inventory/BG_Inventory.hide()
	#$Panel_Exit/BT_ExitInventory.hide()
	#$PanelTablet/background_Tablet.show()
	#var cam = get_tree().get_nodes_in_group("Camera")[0]
	#cam.current = true
#	player.get_node("Base/Cam_Invent").current = false
	#player.get_node("Base/BG_Invent").hide()
	#_Control_back_exited()
	
	
