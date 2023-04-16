extends Control


var master_bus = AudioServer.get_bus_index("Master")

func _ready():
 pause_mode = Node.PAUSE_MODE_PROCESS

func _on_HSlider_Sound_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_bus,true)
	else:
		AudioServer.set_bus_mute(master_bus,false)


func _on_BT_Exit_pressed():
	$Panel_Options.hide()
