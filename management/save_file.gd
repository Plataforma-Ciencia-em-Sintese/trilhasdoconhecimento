extends Node


const SAVE_FILE = "user://save_file.save"
var g_data = {}


func _ready():
	load_data()
	

func save_data():
	var file = File.new()
	file.open(SAVE_FILE, file.WRITE)
	file.store_var(g_data)
	file.close()

func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		g_data = {
			"save1":  0,
			"save2":  0,
			"save3":  0,
			"saveVolume": 0,
			"savePlayer": "saveplayer",
			
		}
		save_data()
	file.open(SAVE_FILE, File.READ)
	g_data = file.get_var()
	file.close()
