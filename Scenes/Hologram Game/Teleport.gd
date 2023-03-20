extends Spatial

func _on_Timer_timeout():
	get_tree().change_scene(GlobalValues.backToScene)
