extends Button

var nameItem: String
var type: String
var descr: String
var image: Texture

var descriptionBox

func _ready():
	descriptionBox = get_tree().get_nodes_in_group("Description")[0]

func _on_Item_BT_mouse_entered():
	descriptionBox.show()
	descriptionBox.get_node("Txt").text = descr

func _on_Item_BT_mouse_exited():
	descriptionBox.hide()
