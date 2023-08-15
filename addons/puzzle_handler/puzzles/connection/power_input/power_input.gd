extends HBoxContainer


var _current_data = null


onready var _panel: Panel = $"%Panel"
onready var _label: Label = $"%Label"


func _ready() -> void:
	_panel.connect("dropped", self, "_on_Panel_dropped")


func _on_Panel_dropped(position: Vector2, data) -> void:
	if _current_data != null:
		_current_data.energy_disconnect()

	_current_data = data
	_current_data.energy_connect(self)


func define_text(text: String) -> void:
	_label.text = text


func get_text() -> String:
	return _label.text


func energy_disconnect() -> void:
	_current_data = null


func get_panel() -> Panel:
	return _panel
