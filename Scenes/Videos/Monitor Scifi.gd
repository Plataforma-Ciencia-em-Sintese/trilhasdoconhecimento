extends Spatial

export var speed = 0.5

func _process(delta):
	rotate_y(speed * delta)

func _on_VideoPlayer_finished():
	$Viewport/VideoPlayer.play()
