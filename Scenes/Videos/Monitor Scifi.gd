extends Spatial

func _on_VideoPlayer_finished():
	$Viewport/VideoPlayer.play()
