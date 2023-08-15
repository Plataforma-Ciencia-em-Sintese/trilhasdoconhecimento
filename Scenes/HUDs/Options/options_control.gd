extends CanvasLayer

onready var save_file = SaveFile.g_data

onready var player = get_tree().get_nodes_in_group("Player")[0]



func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
		
	#Parte de Save 
	$Panel_Options/Fundo/Sound/HSlider_Sound.value = save_file.saveVolume

func _on_HSlider_Sound_value_changed(value):
	$Panel_Options/Fundo/Sound/HSlider_Sound.value = value
	if value == 0:
		Fmod.set_bus_mute(GlobalOptions.bus_path_Master, true)
	else:
		Fmod.set_bus_mute(GlobalOptions.bus_path_Master, false)
		Fmod.set_bus_volume(GlobalOptions.bus_path_Master, value)

func _on_BT_ExitConfig_pressed():
	save_file.saveVolume = $Panel_Options/Fundo/Sound/HSlider_Sound.value
	$Panel_Options/Fundo/Sound/HSlider_Sound.value = save_file.saveVolume
	SaveFile.save_data()
	player.get_node("TabletInformation/PanelTablet").show()
	$Panel_Options/BT_ExitConfig.hide()
	$Panel_Options.hide()


func _on_Panel_exit_pressed():
	save_file.saveVolume = $Panel_Options/Fundo/Sound/HSlider_Sound.value
	$Panel_Options/Fundo/Sound/HSlider_Sound.value = save_file.saveVolume
	SaveFile.save_data()
	player.get_node("TabletInformation/PanelTablet").show()
	$Panel_Options/BT_ExitConfig.hide()
	$Panel_Options.hide()
