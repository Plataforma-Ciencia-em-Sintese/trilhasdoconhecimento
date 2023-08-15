extends CanvasLayer

func start_transition(anim):
	if anim == "fadein":
		$AnimationPlayer.play("FadeIn")
	else:
		$AnimationPlayer.play("FadeOut")

