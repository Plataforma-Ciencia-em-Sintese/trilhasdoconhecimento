extends Panel


signal dropped(position, data)


func drop_data(position: Vector2, data) -> void:
	emit_signal("dropped", position, data)


func can_drop_data(_position: Vector2, _data) -> bool:
	return true



