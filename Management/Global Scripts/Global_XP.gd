extends Node

# Signal global
# Todos os objetos que precisam checar o xp devem possuir esse signal conectado
signal xp(val)
signal lvl()
var skillUI : String = "res://Scenes/Reward Screen/Skill_Unlock_UI.tscn"
var skillsResource : Array
var skillsDirectory : String = "res://Scenes/Inventory/Resource Inventory/Skills Weapons/"

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_up"):
		set_xp(5)
	elif Input.is_action_just_pressed("ui_left"):
		set_xp(35)

func set_xp(value):
	# Manda o signal com o valor do xp para a ui Status
	emit_signal("xp",value)

func unlock_skill():
	# Manda o signal para os botoes in game ja equipados da skill
	emit_signal("lvl")
	# Chama as skills desbloqueadas
	show_skills()

func show_skills():
	# Le o diretorio das skills
	# Pra cada uma, se o lvl atual do jogador esta no msm nivel, manda a resource pra array
	var allSkills = get_files_in_directory(skillsDirectory)
	for i in allSkills.size():
		if !allSkills[i].hasShowed and GlobalValues.levelPlayer >= allSkills[i].levelToUnlock:
			skillsResource.append(allSkills[i])
			allSkills[i].hasShowed = true
			allSkills[i].unlocked = true
	
	# Se tem resources, mostra as skills na interface de skill
	# No final a array e limpa e o ciclo recomeca quando for chamado de novo
	if skillsResource.size() > 0:
		var ui = load(skillUI).instance()
		for i in skillsResource.size():
			ui.resourcesToShow.append(skillsResource[i])
			
		skillsResource.clear()
		add_child(ui)

func get_files_in_directory(path):
	# funcao que acessa a pasta especificada e coleta todos os .tres ja carregados
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif file.ends_with(".tres"):
			files.append(load(path + "/" + file))
	
	dir.list_dir_end()
	return files
