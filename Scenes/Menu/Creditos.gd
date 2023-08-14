extends CanvasLayer
onready var menu = get_tree().get_nodes_in_group("Menu")[0]

func _on_BT_Close_pressed():
	$Panel_creditos.hide()
	menu.get_node("Buttons/Play").show()
	menu.get_node("Buttons/Configure").show()
	menu.get_node("Buttons/Sobre").show()
	menu.get_node("NameGame").show()

func _on_Panel_exit_pressed():
	$Panel_creditos.hide()
	menu.get_node("Buttons/Play").show()
	menu.get_node("Buttons/Configure").show()
	menu.get_node("Buttons/Sobre").show()
	menu.get_node("NameGame").show()
