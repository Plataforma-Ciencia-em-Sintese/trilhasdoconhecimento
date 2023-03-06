extends Node

onready var current_language = (TranslationServer.get_locale())

var id = 0
export (String, "Ariel","Bento","Caio","Clara","Yara") var mainChar
#onready var player = ($Player)

func _ready() -> void:
	# conecta os botões dos idiomas 
	for btn in get_tree().get_nodes_in_group("language_btn"):
		btn.connect("toggled", self, "_on_language_toggled", [btn.name])
		# marca o botão com o idioma atual
		btn.pressed = true if btn.name == current_language else false
	#select player
	for button in get_tree().get_nodes_in_group("play_btn"):
		button.connect("pressed", self, "on_button_pressed", [button])
		button.connect("mouse_exited", self, "mouse_interaction", [button, "exited"])
		button.connect("mouse_entered", self, "mouse_interaction", [button, "entered"])

func _on_language_toggled(button_pressed, language):
	if button_pressed:
		TranslationServer.set_locale(language)
		current_language = language

func select_player_button(button: Button) -> void:
	match button.name:
		"ButtonPlay":
			if (id == 0):
				var _play: bool = get_tree().change_scene("res://Scenes/Menu/Selection_Zone_3D.tscn")
				mainChar == "Bento"
			if (id == 1):
				var _play: bool = get_tree().change_scene("res://Scenes/Menu/Selection_Zone_3D.tscn")
				mainChar == "Clara"
