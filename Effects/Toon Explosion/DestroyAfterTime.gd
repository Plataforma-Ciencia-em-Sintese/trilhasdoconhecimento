extends OmniLight

func _ready():
	$AnimationPlayer.play("LightOut")

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()

