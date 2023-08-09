extends Control

onready var save_file = SaveFile.g_data

var master_bus = AudioServer.get_bus_index("Master")

onready var menu = get_tree().get_nodes_in_group("Menu")[0]


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	$Panel_Options/Fundo/Sound/HSlider_Sound.value = save_file.saveVolume


func _on_HSlider_Sound_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	if value == -30:
		AudioServer.set_bus_mute(master_bus,true) 
	else:
		AudioServer.set_bus_mute(master_bus,false)


func _on_BT_ExitConfig_pressed():
	save_file.saveVolume = $Panel_Options/Fundo/Sound/HSlider_Sound.value
	$Panel_Options/Fundo/Sound/HSlider_Sound.value = save_file.saveVolume
	SaveFile.save_data()
	$Panel_Options.hide()
	menu.get_node("Buttons/Play").show()
	menu.get_node("Buttons/Configure").show()
	menu.get_node("NameGame").show()


func _on_Panel_exit_pressed():
	save_file.saveVolume = $Panel_Options/Fundo/Sound/HSlider_Sound.value
	$Panel_Options/Fundo/Sound/HSlider_Sound.value = save_file.saveVolume
	SaveFile.save_data()
	$Panel_Options.hide()
	menu.get_node("Buttons/Play").show()
	menu.get_node("Buttons/Configure").show()
	menu.get_node("NameGame").show()
