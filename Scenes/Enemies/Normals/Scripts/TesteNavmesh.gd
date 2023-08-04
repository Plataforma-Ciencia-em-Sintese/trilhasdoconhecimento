extends Spatial


func _on_NavTimerEnemy_timeout():
	var player = owner.get_node("Enemy").global_transform.origin
	var nav = owner.owner.get_node("NavigationMeshInstance")
	
	
