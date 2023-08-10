extends CanvasLayer

onready var save_file = SaveFile.g_data


onready var menu = get_tree().get_nodes_in_group("Menu")[0]


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	
	Fmod.set_bus_volume(GlobalValues.bus_path_Master, 10)
	$Panel_Options/Fundo/Sound/HSlider_Sound.value = 10
	
	$Panel_Options/Fundo/Sound/HSlider_Sound.value = save_file.saveVolume

func _on_HSlider_Sound_value_changed(value):
	
	
	if value == 0:
		Fmod.set_bus_mute(GlobalValues.bus_path_Master, true)
	else:
		Fmod.set_bus_mute(GlobalValues.bus_path_Master, false)
		Fmod.set_bus_volume(GlobalValues.bus_path_Master, value)


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
