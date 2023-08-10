extends Control


signal puzzle_response(response)


const AMOUNT_CELLS: int = 5

const _DATA_PATH: String = "res://puzzle_handler/puzzles/connection/data.json"

const _PowerOutput: PackedScene = preload("res://puzzle_handler/puzzles/connection/power_output/power_output.tscn")
const _PowerInput: PackedScene = preload("res://puzzle_handler/puzzles/connection/power_input/power_input.tscn")
const _ElectricLine: PackedScene = preload("res://puzzle_handler/puzzles/connection/electric_line/electric_line.tscn")


var _cells_data: Array = []


onready var _output: VBoxContainer = $"%Output"
onready var _input: VBoxContainer = $"%Input"
onready var _energy: CanvasLayer = $"%Energy"
onready var _progress_bar: ProgressBar = $"%ProgressBar"
onready var _continue: Button = $"%Continue"
onready var _energy_container: VBoxContainer = $"%EnergyContainer"


func _ready() -> void:
	randomize()

	_init_progress_bar()

	_add_cells()

	set_text_children(load_data_from_json(_DATA_PATH))

	shuffle_children(_output)

	shuffle_children(_input)

	_add_electric_lines()


func _on_Close_pressed() -> void:
	emit_signal("puzzle_response", false)


func load_data_from_json(path: String) -> Dictionary:
	var file: File = File.new()
	if not file.file_exists(path):
		push_error("Data not found.")
		return {}

	file.open(path, File.READ)
	var content := JSON.parse(file.get_as_text())
	file.close()

	if typeof(content.result) == TYPE_DICTIONARY:
		return content.result
	else:
		push_error("Unexpected results.")

	return {}


func set_text_children(data_dictionary: Dictionary) -> void:
	if not data_dictionary.empty():

		for i in range(0, data_dictionary.size()):
			_cells_data.append({
				data_dictionary.keys()[i]: data_dictionary.values()[i]
			})
		_cells_data.shuffle()


		for i in range(0, AMOUNT_CELLS):
			_output.get_children()[i]\
					.define_text(_cells_data[i].keys()[0])

			_input.get_children()[i]\
					.define_text(_cells_data[i].values()[0])


func shuffle_children(node: Node) -> void:
	var children: Array = []

	# get children and remove
	for child in node.get_children():
		children.append(child)
		node.remove_child(child)

	# shuffle array
	children.shuffle()

	# set new order
	for child in children:
		node.add_child(child)


func _add_cells() -> void:
	for i in range(0, AMOUNT_CELLS):
		var power_output: HBoxContainer = _PowerOutput.instance()
		_output.add_child(power_output)
		power_output.connect("connection_changed", self, "_on_PowerOutput_connection_changed")

		_input.add_child(_PowerInput.instance())


func _init_progress_bar() -> void:
	_progress_bar.min_value = 0
	_progress_bar.max_value = AMOUNT_CELLS
	_progress_bar.step = 1
	_progress_bar.page = 0
	_progress_bar.value = 0


func _add_electric_lines() -> void:
	for i in range(0, AMOUNT_CELLS):
		var line: Line2D = _ElectricLine.instance()
		_energy.add_child(line)
		_output.get_children()[i].set_energy_line(line)


func _puzzle_finished() -> void:
	_energy_container.hide()

	for electric_line in _energy.get_children():
		_energy.remove_child(electric_line)

	_continue.show()


func _on_PowerOutput_connection_changed() -> void:
	_progress_bar.value = 0

	for power_output in _output.get_children():
		if power_output.get_energy_connection() != null:
			var power_input: HBoxContainer = power_output.get_energy_connection()

			for dict in _cells_data:
				if dict.has(power_output.get_text()):
					if dict[power_output.get_text()] == power_input.get_text():
						_progress_bar.value += 1

						if _progress_bar.value == _progress_bar.max_value:
							_puzzle_finished()


func _on_Continue_pressed() -> void:
	emit_signal("puzzle_response", true)
