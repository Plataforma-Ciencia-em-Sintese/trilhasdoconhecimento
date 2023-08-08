extends Control

onready var save_file = SaveFile.g_data

onready var player = get_tree().get_nodes_in_group("Player")[0]
var master_bus = AudioServer.get_bus_index("Master")


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
