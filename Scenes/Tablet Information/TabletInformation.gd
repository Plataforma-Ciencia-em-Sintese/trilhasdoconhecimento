extends Control


func _ready():
	pass

func _on_BT_Inventory_pressed():
	$Inventory/BG_Inventory.show()

func _on_BT_tablet_pressed():
	$BT_tablet.hide()
	$PanelTablet.show()

func _on_BT_Daily_pressed():
	$PanelTablet/background_Tablet.hide()
	$Scenes/Daily/Panel_Daily.show()
	$Panel_Exit/BT_ExitDaily.show()

func _on_BT_Inventory2_pressed():
	pass # Replace with function body.


func _on_BT_Enemy_pressed():
	$PanelTablet/background_Tablet.hide()
	$Scenes/BestiaryEnemy/Panel_Enemy.show()
	$Panel_Exit/BT_ExitEnemy.show()


func _on_BT_Trails_pressed():
	$PanelTablet/background_Tablet.hide()
	$Scenes/Trails/Panel_trails.show()
	$Panel_Exit/BT_ExitTrails.show()
	


func _on_BT_notables_pressed():
	$PanelTablet/background_Tablet.hide()
	$Scenes/BestiaryNotables/Panel_Notables.show()
	$Panel_Exit/BT_ExitNotable.show()
	

func _on_BT_ExitTablet_pressed():
	$PanelTablet.hide()
	$BT_tablet.show()


# Funções criadas para voltar para tela do Tablet

func _on_BT_ExitEnemy_pressed():
	$Scenes/BestiaryEnemy/Panel_Enemy.hide()
	$Panel_Exit/BT_ExitEnemy.hide()
	$PanelTablet/background_Tablet.show()
	


func _on_BT_ExitNotable_pressed():
	$Scenes/BestiaryNotables/Panel_Notables.hide()
	$Panel_Exit/BT_ExitNotable.hide()
	$PanelTablet/background_Tablet.show()
	


func _on_BT_ExitDaily_pressed():
	$Scenes/Daily/Panel_Daily.hide()
	$Panel_Exit/BT_ExitDaily.hide()
	$PanelTablet/background_Tablet.show()
	


func _on_BT_ExitTrails_pressed():
	$Scenes/Trails/Panel_trails.hide()
	$Panel_Exit/BT_ExitTrails.hide()
	$PanelTablet/background_Tablet.show()
	

