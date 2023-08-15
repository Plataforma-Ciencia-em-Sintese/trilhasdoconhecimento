extends CanvasLayer

# Texto a ser mostrado na tela
var txt : String
export (String) var musicName

func _ready():
	if musicName != "":
		GlobalMusicPlayer.play_sound("set_global",1)
		GlobalMusicPlayer.play_sound("start_event",musicName)
		
	get_tree().paused = true
	$BG/Desc.text = txt

func _on_BT_Continue_pressed():
	get_tree().paused = false
	
	if musicName != "":
		GlobalMusicPlayer.play_sound("set_global",0)
		GlobalMusicPlayer.play_sound("stop_event",musicName)
		
	queue_free()
