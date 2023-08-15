tool
extends Control


export (Color, RGB) var _color: Color = Color.black


onready var color_rect: ColorRect = $"%ColorRect"


func _ready() -> void:
	define_color(color_rect)


func _process(delta: float) -> void:
	if Engine.editor_hint:
		# Code to execute in editor.
		define_color($"%ColorRect")

	if not Engine.editor_hint:
		# Code to execute in game.
		pass

	# Code to execute both in editor and in game.


func define_color(node: ColorRect, alpha: float = 0.28) -> void:
	node.color = _color
	node.color.a = alpha
