extends CanvasLayer

onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	$Scenes/Inventory/BT_Inventario.hide()

func _on_BT_tablet_pressed():
	$BT_tablet.hide()
	$PanelTablet.show()
	player.get_node("Battle_UI").hide()
	player.get_node("MiniMap_UI").hide()
	get_parent().get_node("Inventory/BT_Inventario").hide()
	get_parent().get_node("Inventory").hide()
	get_parent().get_node("Status").hide()
	get_parent().get_node("States/Move").hide()
	


func _on_BT_Invent_pressed():
	$Scenes/Inventory/BG_Inventory.show()
	$PanelTablet.hide()
	


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
