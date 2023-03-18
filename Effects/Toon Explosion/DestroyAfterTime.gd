extends OmniLight

func _ready():
	owner.play()
	owner.get_node("AnimationPlayer").play("LightOut")

func _on_AnimationPlayer_animation_finished(anim_name):
	owner.queue_free()

