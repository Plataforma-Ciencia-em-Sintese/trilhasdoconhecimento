extends HBoxContainer


signal connection_changed


var _energy_line: Line2D = null
var _mouse_entered: bool = false
var _is_energy_connected: bool = false
var _connection: HBoxContainer = null


onready var _label: Label = $"%Label"
onready var _panel: Panel = $"%Panel"


func _ready() -> void:
	_construct_data(self)


func _process(delta: float) -> void:
	if _energy_line != null:
		_energy_line.change_start(
			_panel.rect_global_position + _panel.rect_pivot_offset
		)

	if _is_energy_connected:
		_energy_line.show()

		var panel: Panel = _connection.get_panel()
		_energy_line.change_end(
			panel.rect_global_position + panel.rect_pivot_offset
		)

	elif Input.is_mouse_button_pressed(BUTTON_LEFT):
		if _mouse_entered:
			_energy_line.show()

		_energy_line.change_end(
			get_global_mouse_position()
		)

	else:
		_energy_line.visible = false



func define_text(text: String) -> void:
	_label.text = text


func get_text() -> String:
	return _label.text


func set_energy_line(new_value: Line2D) -> void:
	_energy_line = new_value
	_energy_line.hide()


func energy_connect(power_input: HBoxContainer):
	_connection = power_input
	_is_energy_connected = true
	emit_signal("connection_changed")


func energy_disconnect():
	_is_energy_connected = false
	if _connection != null:
		_connection.energy_disconnect()
	_connection = null
	emit_signal("connection_changed")


func is_energy_connected() -> bool:
	return _is_energy_connected


func get_energy_connection():
	return _connection


func _construct_data(data) -> void:
	_panel.define_data(data)



func _on_Panel_mouse_entered() -> void:
	_mouse_entered = true


func _on_Panel_mouse_exited() -> void:
	_mouse_entered = false
