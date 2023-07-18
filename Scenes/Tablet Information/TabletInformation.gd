extends CanvasLayer

func _ready():
 pause_mode = Node.PAUSE_MODE_PROCESS

func _on_BT_tablet_pressed():
	$BT_tablet.hide()
	$PanelTablet.show()


func _on_BT_Invent_pressed():
	pass # Replace with function body.


func _on_BT_Diario_pressed():
	$Scenes/Daily/Panel_Daily.show()
	$PanelTablet.hide()
	


func _on_BT_Invent3_pressed():
	pass # Replace with function body.


func _on_BT_Bestiario_pressed():
	$Scenes/BestiaryEnemy/Panel_Enemy.show()
	$PanelTablet.hide()


func _on_BT_Contatos_pressed():
	$Scenes/BestiaryNotables/Panel_Notables.show()
	$PanelTablet.hide()


func _on_BT_Trilhas_pressed():
	$Scenes/Trails/Panel_trails.show()
	$PanelTablet.hide()


func _on_BT_ExitTablet_pressed():
	get_tree().paused = false
	$BT_tablet.show()
	$PanelTablet.hide()
