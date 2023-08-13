extends Node


# Controle de Som
var bus_path_Master: String = "bus:/"
var busMaster: AudioBusLayout

var bus_path_Music: String = "bus:/Music"
var busMusic: AudioBusLayout

var bus_path_SFX: String = "bus:/SFX"
var busSFX: AudioBusLayout


func _ready():
	Fmod.set_bus_volume(GlobalOptions.bus_path_Master, 10)
