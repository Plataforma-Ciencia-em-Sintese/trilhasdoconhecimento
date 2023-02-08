extends Control

onready var current_language = (TranslationServer.get_locale())

var playerDir = 0
var player : KinematicBody

func _ready():
	
	#$Button_resolution.text = "Button_resolution"
	
	# conecta os botões dos idiomas 
	for btn in get_tree().get_nodes_in_group("language_btn"):
		btn.connect("toggled", self, "_on_language_toggled", [btn.name])
		# marca o botão com o idioma atual
		btn.pressed = true if btn.name == current_language else false

func _on_language_toggled(button_pressed, language):
	if button_pressed:
		TranslationServer.set_locale(language)
		current_language = language

func instance_node(node, location, pararent):
	var node_instance = node.instance()
	pararent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance
