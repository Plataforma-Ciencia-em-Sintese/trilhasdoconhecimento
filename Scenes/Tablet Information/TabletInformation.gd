extends CanvasLayer

func _ready():
	owner.get_node("Inventory").btnOpenClose = $BT_tablet
	
func _on_BT_tablet_pressed():
	$BT_tablet.hide()
	$PanelTablet.show()
	get_tree().paused = true
	owner.get_node("Battle_UI").hide()
	owner.get_node("MiniMap_UI").hide()
	owner.get_node("Status").hide()
	owner.get_node("States/Move").hide()
	owner.get_node("States/Talking").show()
	
func _on_BT_Invent_pressed():
	owner.get_node("Inventory/BG_Inventory").show()
	owner.get_node("States/Move").hide()
	owner.get_node("States/Talking").show()
	$PanelTablet.hide()
	
func _on_BT_Diario_pressed():
	$Scenes/Daily/Panel_Daily.show()
	$Scenes/Daily/exit_Daily.show()
	$PanelTablet.hide()
	
func _on_BT_Invent3_pressed():
	pass # Replace with function body.

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
