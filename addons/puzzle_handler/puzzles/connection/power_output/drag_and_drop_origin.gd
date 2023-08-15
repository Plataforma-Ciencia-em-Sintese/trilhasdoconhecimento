extends Panel


var _data = null


func get_drag_data(_position: Vector2):
	if _data != null:
		_data.energy_disconnect()

#		var preview: Control = Control.new()
#
#		var color_rect: ColorRect = ColorRect.new()
#		preview.add_child(color_rect)
#		color_rect.rect_size = self.rect_size #Vector2(160, 160)
#		color_rect.rect_position -= color_rect.rect_size / 2
#		color_rect.color = Color(1.0, 0.0, 0.0, 1.0)
#
#		set_drag_preview(preview)

		return _data


func can_drop_data(_position: Vector2, _data) -> bool:
	return false


func define_data(data):
	_data = data
