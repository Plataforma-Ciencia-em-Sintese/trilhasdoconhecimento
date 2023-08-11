extends Spatial

var animator: AnimationTree

func _ready():
	animator = owner.get_node("AnimationTree")

func _physics_process(_delta):
	if is_visible_in_tree():
		talking()
		get_parent().get_node("Move").visible = false
		owner.pointer.hide()

func talking():
	animator.set("parameters/move/blend_amount",0)
