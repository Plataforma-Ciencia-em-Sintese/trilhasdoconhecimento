extends CanvasLayer

# identifica qual objeto e o jogador
onready var player : Node = owner

# node root das armas no inventario
onready var rootWeaponsInventory : Node = $BG_Inventory/Title_Weapon_Left/Weapons_Itens
onready var rootMainWeapon : Node = $BG_Inventory/Title_Weapon_Right/Weapons_Main_Repo
onready var rootSecWeapon : Node = $BG_Inventory/Title_Weapon_Right/Weapons_Sec_Repo
onready var rootSkillMain : Node = $BG_Inventory/Title_Weapon_Right/Weapons_Main_Abilities
onready var rootSkillSec : Node = $BG_Inventory/Title_Weapon_Right/Weapons_Sec_Abilities

# node root dos chips no inventario
onready var rootChipsEquiped : Node = $BG_Inventory/Title_Chips_Right/Chips_Repo
onready var rootChipsInventory : Node = $BG_Inventory/Title_Chips_Left/Chip_Itens

# node root dos consums no inventario e game
onready var rootConsumsEquiped : Node = $BG_Inventory/Title_Consum_Right/Consum_Repo
onready var rootConsumsInventory : Node = $BG_Inventory/Title_Consums_Left/Consum_Itens
onready var rootConsumsInGame : Node = owner.get_node("Battle_UI/Skill_Container")

# node root das armas primaria e secundaria in game (NECESSARIO O NODE FORA DO INVENTARIO)
onready var rootMainWeaponInGame: Node = owner.get_node("Battle_UI/Main_Container/Weapon_Main")
onready var rootSecWeaponInGame: Node = owner.get_node("Battle_UI/Sec_Container/Weapon_Sec")

# node root das skills primaria e secundaria in game (NECESSARIO O NODE FORA DO INVENTARIO)
onready var rootMainSkillsInGame: Node = owner.get_node("Battle_UI/Main_Container/Skills_Main")
onready var rootSecSkillsInGame: Node = owner.get_node("Battle_UI/Sec_Container/Skills_Sec")

#Coleta o node tablet no jogo
onready var tabletInfo : Node = owner.get_node("TabletInformation/PanelTablet")

# itens de descricao do inventario
onready var nameItemTXT: Node = $BG_Inventory/Description_Item/Icon_Item/Item_Name
onready var equipBTN: Node = $BG_Inventory/Description_Item/BT_Equip
onready var descripionItemTXT: Node = $BG_Inventory/Description_Item/Icon_Item/Item_Desc
onready var iconItem: Node = $BG_Inventory/Description_Item/Icon_Item

# Coleta a  barra e texto dos indicadores para mostrar valores ao jogador
onready var previewBarLife : Node = $BG_Inventory/Info_BG/Status_Container/Life/BG_Bar/Preview_Bar
onready var previewTxtLife : Node = $BG_Inventory/Info_BG/Status_Container/Life/Life_Txt
onready var previewBarEnergy : Node = $BG_Inventory/Info_BG/Status_Container/Energy/BG_Bar/Preview_Bar
onready var previewTxtEnergy : Node = $BG_Inventory/Info_BG/Status_Container/Energy/Energy_Txt
onready var previewBarATKMain : Node = $BG_Inventory/Info_BG/Status_Container/ATK_Main/BG_Bar/Preview_Bar
onready var previewTxtATKMain : Node = $BG_Inventory/Info_BG/Status_Container/ATK_Main/ATKMain_Txt
onready var previewBarATKSec : Node = $BG_Inventory/Info_BG/Status_Container/ATK_Sec/BG_Bar/Preview_Bar
onready var previewTxtATKSec : Node = $BG_Inventory/Info_BG/Status_Container/ATK_Sec/ATKSec_Txt
onready var previewBarSpeed : Node = $BG_Inventory/Info_BG/Status_Container/Speed_Run/BG_Bar/Preview_Bar
onready var previewTxtSpeed : Node = $BG_Inventory/Info_BG/Status_Container/Speed_Run/Speed_Txt

# identifica os scripts de valores dos itens
# todas devem ficar na pasta do caminho especificado alem do mesmo nome das armas
export (String) var weaponsResourcePath = "res://Scenes/Inventory/Resource Inventory/Weapons"
export (String) var chipsResourcePath = "res://Scenes/Inventory/Resource Inventory/Chips/"
export (String) var consumsResourcePath = "res://Scenes/Inventory/Resource Inventory/Consums/"

# Resource contendo os efeitos sonoros do inventario
export (Resource) var sfxResource

# identifica o botao base do inventario que sera criado representando os itens
var btnInventory : Resource = load("res://Scenes/Inventory/Scene/BTN_Inventory.tscn")

# identifica o botao base in game que sera criado representando os itens
var btnInGame : Resource = load("res://Scenes/Inventory/Scene/BTN_In_Game.tscn")

# Armazena o botao e a resource a ser presetado quando um item for equipado ou deletado
var resourceFromButton : Resource
var objectButton : Node

# Identifica se o botao vai equipar ou deletar um item
var deleteOrAddButton : String

# Identifica a ordem / tipo do botao para ser deletado
var btnOrderType : String

# Valores que serao calculados temporariamente e aplicados quando setar o item
var tempLife : float = 0
var tempEnergy : float = 0
var tempATKMain : float = 0
var tempATKSec : float = 0
var tempSpeed : float = 0

func _ready():
	# Deleta os itens quando iniciar uma nova cena
	delete_itens()
	# Esconde a descriçao do item
	hide_show_item_desc(false)
	# Acessa a pasta contendo os arquivos de valores .tres
	# Com o loop para cada arquivo, sera criado um botao com as informacoes do item
	var allWeapons = get_files_in_directory(weaponsResourcePath)
	for i in allWeapons.size():
		# Cria uma nova instancia
		var weaponBTN = btnInventory.instance()
		# Acessa a resource da variavel
		var weaponResource = allWeapons[i]
		# Passa a resource para o botao trabalhar com os valores quando clicado
		weaponBTN.buttonResource = weaponResource
		weaponBTN.connect("change_item",self,"preview_item")
		# Carrega o icone no botao
		weaponBTN.icon = weaponResource.icon
		# Add no root node do item
		rootWeaponsInventory.add_child(weaponBTN)
	
	var allChips = get_files_in_directory(chipsResourcePath)
	for i in allChips.size():
		# Cria uma nova instancia
		var chipBTN = btnInventory.instance()
		# Acessa a resource da variavel
		var chipResource = allChips[i]
		# Passa a resource para o botao trabalhar com os valores quando clicado
		chipBTN.buttonResource = chipResource
		chipBTN.connect("change_item",self,"preview_item")
		# Carrega o icone no botao
		chipBTN.icon = chipResource.icon
		# Add no root node do item
		rootChipsInventory.add_child(chipBTN)
	
	var allConsums = get_files_in_directory(consumsResourcePath)
	for i in allConsums.size():
		if allConsums[i].quant > 0:
			# Cria uma nova instancia
			var consumBTN = btnInventory.instance()
			# Acessa a resource da variavel
			var consumResource = allConsums[i]
			# Passa a resource para o botao trabalhar com os valores quando clicado
			consumBTN.buttonResource = consumResource
			consumBTN.connect("change_item",self,"preview_item")
			# Carrega o icone no botao
			consumBTN.icon = consumResource.icon
			# Add no root node do item
			rootConsumsInventory.add_child(consumBTN)

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

func preview_item(obj):
	# Quando algum botao for pressionado,o sistema armazena antes os valores pra depois aplicar
	objectButton = obj
	resourceFromButton = obj.buttonResource
	nameItemTXT.text = resourceFromButton.name
	descripionItemTXT.text = resourceFromButton.description
	iconItem.texture = resourceFromButton.icon
	
	# Mostra a descriçao dos itens
	hide_show_item_desc(true)
	
	# Compara o tipo da resource
	if resourceFromButton.type == "Weapon":
		play_sfx(sfxResource.sfx["SelecionarItemArma"])
		if !obj.isEquiped:
			# Realiza o calculo da arma e informa se e primaria ou secundaria
			if rootMainWeapon.get_child_count() <= 0:
				get_weapons_calculation("Main",1)
				if resourceFromButton.atkOperation != "N/D":
					show_or_hide_informations("ATKMain","Show")
					show_or_hide_informations("ATKSec","Hide")
			else:
				get_weapons_calculation("Sec",1)
				if resourceFromButton.atkOperation != "N/D":
					show_or_hide_informations("ATKSec","Show")
					show_or_hide_informations("ATKMain","Hide")
		else:
			btnOrderType = obj.weaponOrder
			# Realiza o calculo da arma e informa se e primaria ou secundaria
			if btnOrderType == "Main":
				get_weapons_calculation("Main",-1)
				if resourceFromButton.atkOperation != "N/D":
					show_or_hide_informations("ATKMain","Show")
					show_or_hide_informations("ATKSec","Hide")
			else:
				get_weapons_calculation("Sec",-1)
				if resourceFromButton.atkOperation != "N/D":
					show_or_hide_informations("ATKSec","Show")
					show_or_hide_informations("ATKMain","Hide")
		# Mostra a barra de preview e o texto tambem com o valor temporario de cada atributo
		if resourceFromButton.lifeOperation != "N/D":
			show_or_hide_informations("Life","Show")
		else:
			show_or_hide_informations("Life","Hide")
			
		if resourceFromButton.energyOperation != "N/D":
			show_or_hide_informations("Energy","Show")
		else:
			show_or_hide_informations("Energy","Hide")

		if resourceFromButton.speedOperation != "N/D":
			show_or_hide_informations("Speed","Show")
		else:
			show_or_hide_informations("Speed","Hide")
	elif resourceFromButton.type == "Chip":
		play_sfx(sfxResource.sfx["SelecionarItemChipMelhoria"])
		# Se o chip estiver equipado soma, senao subtrai o valor
		if !obj.isEquiped:
			get_chips_calculation(1)
		else:
			get_chips_calculation(-1)
			
		# Mostra a barra de preview e o texto tambem com o valor temporario de cada atributo
		if resourceFromButton.atkBoost > 0:
			show_or_hide_informations("ATKMain","Show")
			show_or_hide_informations("ATKSec","Show")
		else:
			show_or_hide_informations("ATKMain","Hide")
			show_or_hide_informations("ATKSec","Hide")
		
		if resourceFromButton.lifeBoost > 0:
			show_or_hide_informations("Life","Show")
		else:
			show_or_hide_informations("Life","Hide")
			
		if resourceFromButton.energyBoost > 0:
			show_or_hide_informations("Energy","Show")
		else:
			show_or_hide_informations("Energy","Hide")

		if resourceFromButton.speedBoost > 0:
			show_or_hide_informations("Speed","Show")
		else:
			show_or_hide_informations("Speed","Hide")
	elif resourceFromButton.type == "Consum":
		play_sfx(sfxResource.sfx["SelecionarItemConsumivel"])
		show_or_hide_informations("ATKMain","Hide")
		show_or_hide_informations("ATKSec","Hide")
		show_or_hide_informations("Life","Hide")
		show_or_hide_informations("Energy","Hide")
		show_or_hide_informations("Speed","Hide")

	# Se o botao informar alguma desses estados de equipar a acao acontece
	if !obj.isEquiped:
		deleteOrAddButton = "Equipar"
	else:
		deleteOrAddButton = "Deletar"
	
	equipBTN.text = deleteOrAddButton

func _on_BT_Equip_pressed():
	# Esconde a descriçao dos itens
	hide_show_item_desc(false)
	if deleteOrAddButton == "Equipar":
		set_itens()
	else:
		delete_itens()
		play_sfx(sfxResource.sfx["BotaoLimpar"])
	
	# Preseta os valores pro script global
	# Todos veem prontos independente da operacao remover ou add novo item
	GlobalValues.lifeActual = tempLife
	GlobalValues.energyActual = tempEnergy
	GlobalValues.speedActual = tempSpeed
	GlobalValues.atkMainActual = tempATKMain
	GlobalValues.atkSecActual = tempATKSec

	show_or_hide_informations("Life","Hide")
	show_or_hide_informations("Energy","Hide")
	show_or_hide_informations("Speed","Hide")
	show_or_hide_informations("ATKMain","Hide")
	show_or_hide_informations("ATKSec","Hide")

func set_itens():
	# Add botao inventario
	# Passa as informacoes padrao do item como icone e resource
	# Conecta o mesmo signal de quando foi criado para o inventario receber resposta
	var itemBTN = btnInventory.instance()
	itemBTN.buttonResource = resourceFromButton
	itemBTN.icon = resourceFromButton.icon
	itemBTN.isEquiped = true
	itemBTN.connect("change_item",self,"preview_item")
	# Esconde o botao do inventario
	objectButton.hide()
	# Classifica os itens e executa a acao de acordo com o tipo
	if resourceFromButton.type == "Weapon":
		# Add botao ingame
		# O proprio botao le e preseta as informacoes como icone
		var inGameBTN = btnInGame.instance()
		inGameBTN.buttonResource = resourceFromButton
		# O novo botao recebe sua referencia no inventario
		itemBTN.btnLinked = objectButton
		# Altera a arma da mao do jogador
		player.change_weapons(resourceFromButton.name)
		# Toca o sfx correspondente
		play_sfx(sfxResource.sfx["EquiparItemArma"])
		#---------------------------
		# Se nao tem arma main
		if rootMainWeapon.get_child_count() <= 0:
			# Ordem da arma
			itemBTN.weaponOrder = "Main"
			# Arma equipada invent
			rootMainWeapon.add_child(itemBTN)
			# Arma equipada in game
			rootMainWeaponInGame.add_child(inGameBTN)
			# Cria uma nova imagem dinamicamente para representar as skills das armas
			for i in resourceFromButton.skillsInOrder.size():
				# Add imagem pro inventario
				var img = TextureRect.new()
				img.texture = resourceFromButton.skillsInOrder[i].icon
				img.expand = true
				img.size_flags_horizontal += TextureRect.SIZE_EXPAND
				img.size_flags_vertical += TextureRect.SIZE_EXPAND
				rootSkillMain.add_child(img)
				# Add botao na cena In game
				var btn = btnInGame.instance()
				btn.buttonResource = resourceFromButton.skillsInOrder[i]
				rootMainSkillsInGame.add_child(btn)
		else:
			# Ordem da arma
			itemBTN.weaponOrder = "Sec"
			# Arma equipada invent
			rootSecWeapon.add_child(itemBTN)
			# Arma equipada in game
			rootSecWeaponInGame.add_child(inGameBTN)
			# Cria uma nova imagem dinamicamente para representar as skills das armas
			for i in resourceFromButton.skillsInOrder.size():
				# Add imagem pro inventario
				var img = TextureRect.new()
				img.texture = resourceFromButton.skillsInOrder[i].icon
				img.expand = true
				img.size_flags_horizontal += TextureRect.SIZE_EXPAND
				img.size_flags_vertical += TextureRect.SIZE_EXPAND
				rootSkillSec.add_child(img)
				# Add botao na cena In game
				var btn = btnInGame.instance()
				btn.buttonResource = resourceFromButton.skillsInOrder[i]
				rootSecSkillsInGame.add_child(btn)
	elif resourceFromButton.type == "Chip":
		itemBTN.btnLinked = objectButton
		rootChipsEquiped.add_child(itemBTN)
		# Toca o sfx correspondente
		play_sfx(sfxResource.sfx["EquiparItemChipMelhoria"])
	elif resourceFromButton.type == "Consum":
		# Add botao ingame
		# O proprio botao le e preseta as informacoes como icone
		var inGameBTN = btnInGame.instance()
		inGameBTN.buttonResource = resourceFromButton
		# O novo botao recebe sua referencia no inventario
		itemBTN.btnLinked = objectButton
		itemBTN.btnConsumLinked = inGameBTN
		inGameBTN.btnRefConsum = itemBTN
		rootConsumsEquiped.add_child(itemBTN)
		rootConsumsInGame.add_child(inGameBTN)
		# Toca o sfx correspondente
		play_sfx(sfxResource.sfx["EquiparItemConsumivel"])
		
func delete_itens():
	# Se a funcao e chamada de algum botao
	if resourceFromButton != null:
		# Linka o botao do inventario ao novo
		objectButton.btnLinked.show()
		# Se ele e do tipo arma, compara se ele e main ou secundario
		# Pra cada um dos nodes root desse tipo de item, tudo e destruido
		if resourceFromButton.type == "Weapon":
			if btnOrderType == "Main":
				rootMainWeapon.get_child(0).queue_free()
				rootMainWeaponInGame.get_child(0).queue_free()
				
				for i in rootSkillMain.get_child_count():
					rootSkillMain.get_child(i).queue_free()
					rootMainSkillsInGame.get_child(i).queue_free()
			else:
				rootSecWeapon.get_child(0).queue_free()
				rootSecWeaponInGame.get_child(0).queue_free()
				
				for i in rootSkillSec.get_child_count():
					rootSkillSec.get_child(i).queue_free()
					rootSecSkillsInGame.get_child(i).queue_free()
		elif resourceFromButton.type == "Chip":
			objectButton.queue_free()
		elif resourceFromButton.type == "Consum":
			objectButton.btnConsumLinked.queue_free()
			objectButton.queue_free()
	else:
		# Se a funcao e chamada sozinha, destroi todos os childs dos roots
		for i in rootMainWeapon.get_child_count():
			rootMainWeapon.get_child(0).queue_free()
		
		for i in rootMainWeaponInGame.get_child_count():
			rootMainWeaponInGame.get_child(0).queue_free()
		
		for i in rootSecWeapon.get_child_count():
			rootSecWeapon.get_child(0).queue_free()
		
		for i in rootSecWeaponInGame.get_child_count():
			rootSecWeaponInGame.get_child(0).queue_free()
		
		for i in rootSkillMain.get_child_count():
			rootSkillMain.get_child(i).queue_free()
		
		for i in rootMainSkillsInGame.get_child_count():
			rootMainSkillsInGame.get_child(i).queue_free()
		
		for i in rootSkillSec.get_child_count():
			rootSkillSec.get_child(i).queue_free()
		
		for i in rootSecSkillsInGame.get_child_count():
			rootSecSkillsInGame.get_child(i).queue_free()
		
		for i in rootChipsEquiped.get_child_count():
			rootChipsEquiped.get_child(i).queue_free()
		
		for i in rootChipsInventory.get_child_count():
			rootChipsInventory.get_child(i).queue_free()
			
		for i in rootConsumsEquiped.get_child_count():
			rootConsumsEquiped.get_child(i).queue_free()
			
		for i in rootConsumsInGame.get_child_count():
			rootConsumsInGame.get_child(i).queue_free()

func _on_BT_Close_pressed():
	$BG_Inventory.hide()
	tabletInfo.show()

func get_weapons_calculation(type,operation):
	# Realiza os calculos de fracao de acordo com os valores dados pela Resource da arma
	# Se o jogador vai add uma nova arma,preseta novos valores
	# Para remover os valores, basta receber o operation -1, assim a operaçao é invertida
	if GlobalValues.lifeActual <= 0:
		# Compara se o jogador nao tem nada equipado como arma e se sua vida ainda é a base
		if resourceFromButton.lifeOperation == "-":
			tempLife = GlobalValues.life - (calculate_status(GlobalValues.life,resourceFromButton.numLife,resourceFromButton.denLife) * operation)
		elif resourceFromButton.lifeOperation == "+":
			tempLife = GlobalValues.life + (calculate_status(GlobalValues.life,resourceFromButton.numLife,resourceFromButton.denLife) * operation)
	else:
		# Compara se o jogador ja tiver modificado sua vida base, o calculo e realizado pela vida atual
		if resourceFromButton.lifeOperation == "-":
			tempLife = GlobalValues.lifeActual - (calculate_status(GlobalValues.life,resourceFromButton.numLife,resourceFromButton.denLife) * operation)
		elif resourceFromButton.lifeOperation == "+":
			tempLife = GlobalValues.lifeActual + (calculate_status(GlobalValues.life,resourceFromButton.numLife,resourceFromButton.denLife) * operation)
	
	if GlobalValues.energyActual <= 0:
		if resourceFromButton.energyOperation == "-":
			tempEnergy =  GlobalValues.energy - (calculate_status(GlobalValues.energy,resourceFromButton.numEnergy,resourceFromButton.denEnergy) * operation) 
		elif resourceFromButton.energyOperation == "+":
			tempEnergy =  GlobalValues.energy + (calculate_status(GlobalValues.energy,resourceFromButton.numEnergy,resourceFromButton.denEnergy) * operation)
	else:
		if resourceFromButton.energyOperation == "-":
			tempEnergy =  GlobalValues.energyActual - (calculate_status(GlobalValues.energy,resourceFromButton.numEnergy,resourceFromButton.denEnergy) * operation)
		elif resourceFromButton.energyOperation == "+":
			tempEnergy =  GlobalValues.energyActual + (calculate_status(GlobalValues.energy,resourceFromButton.numEnergy,resourceFromButton.denEnergy) * operation)
	
	if GlobalValues.speedActual <= 0:
		if resourceFromButton.speedOperation == "-":
			tempSpeed =  GlobalValues.speed - (calculate_status(GlobalValues.speed,resourceFromButton.numSpeed,resourceFromButton.denSpeed) * operation)
		elif resourceFromButton.speedOperation == "+":
			tempSpeed =  GlobalValues.speed + (calculate_status(GlobalValues.speed,resourceFromButton.numSpeed,resourceFromButton.denSpeed) * operation)
	else:
		if resourceFromButton.speedOperation == "-":
			tempSpeed =  GlobalValues.speedActual - (calculate_status(GlobalValues.speed,resourceFromButton.numSpeed,resourceFromButton.denSpeed) * operation)
		elif resourceFromButton.speedOperation == "+":
			tempSpeed =  GlobalValues.speedActual + (calculate_status(GlobalValues.speed,resourceFromButton.numSpeed,resourceFromButton.denSpeed) * operation)
			
	if type == "Main":
		if GlobalValues.atkMainActual <= 0:
			if resourceFromButton.atkOperation == "-":
				tempATKMain =  GlobalValues.atkMain - (calculate_status(GlobalValues.atkMain,resourceFromButton.numATK,resourceFromButton.denATK) * operation)
			elif resourceFromButton.atkOperation == "+":
				tempATKMain =  GlobalValues.atkMain + (calculate_status(GlobalValues.atkMain,resourceFromButton.numATK,resourceFromButton.denATK) * operation)
		else:
			if resourceFromButton.atkOperation == "-":
				tempATKMain =  GlobalValues.atkMainActual - (calculate_status(GlobalValues.atkMain,resourceFromButton.numATK,resourceFromButton.denATK) * operation)
			elif resourceFromButton.atkOperation == "+":
				tempATKMain =  GlobalValues.atkMainActual + (calculate_status(GlobalValues.atkMain,resourceFromButton.numATK,resourceFromButton.denATK) * operation)
	else:
			if GlobalValues.atkSecActual <= 0:
				if resourceFromButton.atkOperation == "-":
					tempATKSec =  GlobalValues.atkSec - (calculate_status(GlobalValues.atkSec,resourceFromButton.numATK,resourceFromButton.denATK) * operation)
				elif resourceFromButton.atkOperation == "+":
					tempATKSec =  GlobalValues.atkSec + (calculate_status(GlobalValues.atkSec,resourceFromButton.numATK,resourceFromButton.denATK) * operation)
			else:
				if resourceFromButton.atkOperation == "-":
					tempATKSec =  GlobalValues.atkSecActual - (calculate_status(GlobalValues.atkSec,resourceFromButton.numATK,resourceFromButton.denATK) * operation)
				elif resourceFromButton.atkOperation == "+":
					tempATKSec =  GlobalValues.atkSecActual + (calculate_status(GlobalValues.atkSec,resourceFromButton.numATK,resourceFromButton.denATK) * operation)

func get_chips_calculation(operation):
	# Realiza o calculo dos chips 
	# Se tiver algo como energia, compara se vai usar o valor energyActual ou energy
	if resourceFromButton.energyBoost > 0:
		if GlobalValues.energyActual <= 0:
			# Soma o valor com o valor base
			tempEnergy = (GlobalValues.energy + resourceFromButton.energyBoost) * operation
		else:
			# Ou soma extra se ja tiver algo equipado
			tempEnergy = GlobalValues.energyActual + (resourceFromButton.energyBoost * operation)
#
	if resourceFromButton.lifeBoost > 0:
		if GlobalValues.lifeActual <= 0:
			tempLife = (GlobalValues.life + resourceFromButton.lifeBoost) * operation
		else:
			tempLife = GlobalValues.lifeActual + (resourceFromButton.lifeBoost * operation)
	
	if resourceFromButton.speedBoost > 0:
		if GlobalValues.speedActual <= 0:
			tempSpeed = (GlobalValues.speed + resourceFromButton.speedBoost) * operation
		else:
			tempSpeed = GlobalValues.speedActual + (resourceFromButton.speedBoost * operation)

	if resourceFromButton.atkBoost > 0:
		if GlobalValues.atkMainActual <= 0:
			tempATKMain = (GlobalValues.atkMain + resourceFromButton.atkBoost) * operation
		else:
			tempATKMain = GlobalValues.atkMainActual + (resourceFromButton.atkBoost * operation)
			
		if GlobalValues.atkSecActual <= 0:
			tempATKSec = (GlobalValues.atkSec + resourceFromButton.atkBoost) * operation
		else:
			tempATKSec = GlobalValues.atkSecActual + (resourceFromButton.atkBoost * operation)
		
func calculate_status(baseValue,numerator,denominator):
	return (baseValue/denominator) * numerator

func show_or_hide_informations(info,status):
	# Seta a interface com as barras e o texto com cores
	if info == "Life":
		if status == "Show":
			previewBarLife.show()
			previewBarLife.value = tempLife
			previewTxtLife.text = "Vida | " + str(tempLife)
			
			if GlobalValues.lifeActual <= 0:
				if tempLife < GlobalValues.life:
					previewTxtLife.modulate = Color.red
					previewBarLife.get("custom_styles/fg").bg_color = Color.red
				else:
					previewTxtLife.modulate = Color.green
					previewBarLife.get("custom_styles/fg").bg_color = Color.green
			else:
				if tempLife < GlobalValues.lifeActual:
					previewTxtLife.modulate = Color.red
					previewBarLife.get("custom_styles/fg").bg_color = Color.red
				else:
					previewTxtLife.modulate = Color.green
					previewBarLife.get("custom_styles/fg").bg_color = Color.green
		else:
			previewBarLife.hide()
			previewTxtLife.modulate = Color.white
			
			if GlobalValues.lifeActual <= 0:
				previewTxtLife.text = "Vida | " + str(GlobalValues.life)
			else:
				previewTxtLife.text = "Vida | " + str(GlobalValues.lifeActual)
	elif info == "Energy":
		if status == "Show":
			previewBarEnergy.show()
			previewBarEnergy.value = tempEnergy
			previewTxtEnergy.text = "Energia | " + str(tempEnergy)
			
			if GlobalValues.energyActual <= 0:
				if tempEnergy < GlobalValues.energy:
					previewTxtEnergy.modulate = Color.red
					previewBarEnergy.get("custom_styles/fg").bg_color = Color.red
				else:
					previewTxtEnergy.modulate = Color.green
					previewBarEnergy.get("custom_styles/fg").bg_color = Color.green
			else:
				if tempEnergy < GlobalValues.energyActual:
					previewTxtEnergy.modulate = Color.red
					previewBarEnergy.get("custom_styles/fg").bg_color = Color.red
				else:
					previewTxtEnergy.modulate = Color.green
					previewBarEnergy.get("custom_styles/fg").bg_color = Color.green
		else:
			previewBarEnergy.hide()
			previewTxtEnergy.modulate = Color.white
			
			if GlobalValues.energyActual <= 0:
				previewTxtEnergy.text = "Energia | " + str(GlobalValues.energy)
			else:
				previewTxtEnergy.text = "Energia | " + str(GlobalValues.energyActual)
	elif info == "Speed":
		if status == "Show":
			previewBarSpeed.show()
			previewBarSpeed.value = tempSpeed
			previewTxtSpeed.text = "Veloc. | " + str(tempSpeed)
			
			if GlobalValues.speedActual <= 0:
				if tempSpeed < GlobalValues.speed:
					previewTxtSpeed.modulate = Color.red
					previewBarSpeed.get("custom_styles/fg").bg_color = Color.red
				else:
					previewTxtSpeed.modulate = Color.green
					previewBarSpeed.get("custom_styles/fg").bg_color = Color.green
			else:
				if tempSpeed < GlobalValues.speedActual:
					previewTxtSpeed.modulate = Color.red
					previewBarSpeed.get("custom_styles/fg").bg_color = Color.red
				else:
					previewTxtSpeed.modulate = Color.green
					previewBarSpeed.get("custom_styles/fg").bg_color = Color.green
		else:
			previewBarSpeed.hide()
			previewTxtSpeed.modulate = Color.white
			
			if GlobalValues.speedActual <= 0:
				previewTxtSpeed.text = "Veloc. | " + str(GlobalValues.speed)
			else:
				previewTxtSpeed.text = "Veloc. | " + str(GlobalValues.speedActual)
	elif info == "ATKMain":
		if status == "Show":
			previewBarATKMain.show()
			previewBarATKMain.value = tempATKMain
			previewTxtATKMain.text = "ATK Main | " + str(tempATKMain)
			
			if GlobalValues.atkMainActual <= 0:
				if tempATKMain < GlobalValues.atkMain:
					previewTxtATKMain.modulate = Color.red
					previewBarATKMain.get("custom_styles/fg").bg_color = Color.red
				else:
					previewTxtATKMain.modulate = Color.green
					previewBarATKMain.get("custom_styles/fg").bg_color = Color.green
			else:
				if tempATKMain < GlobalValues.atkMainActual:
					previewTxtATKMain.modulate = Color.red
					previewBarATKMain.get("custom_styles/fg").bg_color = Color.red
				else:
					previewTxtATKMain.modulate = Color.green
					previewBarATKMain.get("custom_styles/fg").bg_color = Color.green
		else:
			previewBarATKMain.hide()
			previewTxtATKMain.modulate = Color.white
			
			if GlobalValues.atkMainActual <= 0:
				previewTxtATKMain.text = "ATK Main | " + str(GlobalValues.atkMain)
			else:
				previewTxtATKMain.text = "ATK Main | " + str(GlobalValues.atkMainActual)
	elif info == "ATKSec":
		if status == "Show":
			previewBarATKSec.show()
			previewBarATKSec.value = tempATKSec
			previewTxtATKSec.text = "ATK Sec | " + str(tempATKSec)
			
			if GlobalValues.atkSecActual <= 0:
				if tempATKSec < GlobalValues.atkMain:
					previewTxtATKSec.modulate = Color.red
					previewBarATKSec.get("custom_styles/fg").bg_color = Color.red
				else:
					previewTxtATKSec.modulate = Color.green
					previewBarATKSec.get("custom_styles/fg").bg_color = Color.green
			else:
				if tempATKSec < GlobalValues.atkSecActual:
					previewTxtATKSec.modulate = Color.red
					previewBarATKSec.get("custom_styles/fg").bg_color = Color.red
				else:
					previewTxtATKSec.modulate = Color.green
					previewBarATKSec.get("custom_styles/fg").bg_color = Color.green
		else:
			previewBarATKSec.hide()
			previewTxtATKSec.modulate = Color.white
			
			if GlobalValues.atkSecActual <= 0:
				previewTxtATKSec.text = "ATK Sec | " + str(GlobalValues.atkSec)
			else:
				previewTxtATKSec.text = "ATK Sec | " + str(GlobalValues.atkSecActual)

func hide_show_item_desc(status):
	if status:
		nameItemTXT.show()
		equipBTN.show()
		descripionItemTXT.show()
		iconItem.show()
		equipBTN.show()
	else:
		nameItemTXT.hide()
		equipBTN.hide()
		descripionItemTXT.hide()
		iconItem.hide()
		equipBTN.hide()

func _on_Background_Invent_gui_input(event):
	# Normaliza a UI quando clicar fora dos botoes
	if event is InputEventMouseButton:
		if event.pressed:
			show_or_hide_informations("ATKMain","Hide")
			show_or_hide_informations("ATKSec","Hide")
			show_or_hide_informations("Life","Hide")
			show_or_hide_informations("Energy","Hide")
			show_or_hide_informations("Speed","Hide")
			hide_show_item_desc(false)

func play_sfx(name):
	if name:
		Fmod.play_one_shot(name,self)
