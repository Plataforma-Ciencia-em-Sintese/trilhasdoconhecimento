extends Area

func _on_Wall_Area_area_entered(area):
	if area.is_in_group("Prop"):
		area.speed *= -1
