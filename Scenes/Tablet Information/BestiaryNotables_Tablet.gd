extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_BT_ExitNotable_pressed():
	$Scenes/BestiaryNotables/Panel_Notables.hide()
	$Panel_Exit/BT_ExitNotable.hide()
	$PanelTablet/background_Tablet.show()
