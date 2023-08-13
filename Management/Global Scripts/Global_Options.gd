extends Node

#Sistema de Save

onready var save_file = SaveFile.g_data
var saveFilePath = "user://save_file.save"

# Controle de Som
var bus_path_Master: String = "bus:/"
var busMaster: AudioBusLayout

var bus_path_Music: String = "bus:/Music"
var busMusic: AudioBusLayout

var bus_path_SFX: String = "bus:/SFX"
var busSFX: AudioBusLayout


func _ready():
	if File.new().file_exists(saveFilePath):
		Fmod.set_bus_volume(GlobalOptions.bus_path_Master, save_file.saveVolume)
	else:
		Fmod.set_bus_volume(GlobalOptions.bus_path_Master, 10)
