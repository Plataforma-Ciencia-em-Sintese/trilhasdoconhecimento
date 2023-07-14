extends CanvasLayer



func _on_Show_MiniMap_pressed():
	$MiniMap_Node.show()
	$Hide_MiniMap.show()
	$Show_MiniMap.hide()
	


func _on_Hide_MiniMap_pressed():
	$MiniMap_Node.hide()
	$Hide_MiniMap.hide()
	$Show_MiniMap.show()
