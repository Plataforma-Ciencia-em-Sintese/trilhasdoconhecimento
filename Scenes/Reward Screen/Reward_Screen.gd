extends CanvasLayer

var actualItensAtk = []
var actualItensConsum = []
var rewardItensATK = []
var rewardItensConsum = []
var choosedRewards = []
var id = 0
var chooseAtk
var chooseConsum
onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var pointer = get_tree().get_nodes_in_group("Pointer")[0]
var stopPlayer = false

func set_reward():
	stopPlayer = true
	# checa quais itens atualmente tem o jogador
	for i in GlobalValues.atkItens.size():
		actualItensAtk.append(GlobalValues.atkItens.keys()[i])
	for i in GlobalValues.consumItens.size():
		actualItensConsum.append(GlobalValues.consumItens.keys()[i])
	
	print("o que tenho: ",actualItensAtk, " quant: ", actualItensAtk.size())
	print("o que tenho: ",actualItensConsum, " quant: ", actualItensConsum.size())
	
	# organiza quais itens nao tem o jogador
	if actualItensAtk.size() > 0:
		for i in GlobalValues.atkPassivesReward.size():
			print("rodada ",i)
			print("Comparando se tem item " , GlobalValues.atkPassivesReward.keys()[i])
			for j in actualItensAtk.size():
				if GlobalValues.atkPassivesReward.keys()[i] != actualItensAtk[j]:
					id += 1
					print("Comparando com o ataque :",id)
				else:
					print("Ja tem o " , GlobalValues.atkPassivesReward.keys()[i])
					id = 0
					break
				if id > actualItensAtk.size()-1:
					rewardItensATK.append(GlobalValues.atkPassivesReward.keys()[i])
					print("item ", GlobalValues.atkPassivesReward.keys()[i]," nao tem")
					id = 0
					break
	else:
		for i in GlobalValues.atkPassivesReward.size():
			rewardItensATK.append(GlobalValues.atkPassivesReward.keys()[i])
	
	if actualItensConsum.size() > 0:
		for i in GlobalValues.consumRewards.size():
			print("rodada ",i)
			print("Comparando se tem item " , GlobalValues.consumRewards.keys()[i])
			for j in actualItensConsum.size():
				if GlobalValues.consumRewards.keys()[i] != actualItensConsum[j]:
					id += 1
					print("Comparando com o ataque :",id)
				else:
					print("Ja tem o " , GlobalValues.consumRewards.keys()[i])
					id = 0
					break
				if id > actualItensConsum.size()-1:
					rewardItensConsum.append(GlobalValues.consumRewards.keys()[i])
					print("item ", GlobalValues.consumRewards.keys()[i]," nao tem")
					id = 0
					break
	else:
		for i in GlobalValues.consumRewards.size():
			rewardItensConsum.append(GlobalValues.consumRewards.keys()[i])
	
	print("recompensas: ",rewardItensATK)
	print("recompensas: ",rewardItensConsum)
	
	# escolhe o ataque a ser mostrado pro jogador
	var container = $Container
	if rewardItensATK.size() > 0:
		randomize()
		chooseAtk = randi() % rewardItensATK.size()
		var src = GlobalValues.atkPassivesReward.get(rewardItensATK[chooseAtk])
		var srcImg = src[1]
		var srcDesc = src[2]
	
		container.get_child(0).get_node("Img").texture = load(srcImg)
		container.get_child(0).get_node("Desc").text = srcDesc
		container.get_child(0).get_node("Title").text = rewardItensATK[chooseAtk]
		choosedRewards.append(GlobalValues.atkPassivesReward.keys()[chooseAtk])
	else:
		container.get_child(0).hide()
	
	# escolhe o consumivel a ser mostrado pro jogador
	if rewardItensConsum.size() > 0:
		randomize()
		chooseConsum = randi() % rewardItensConsum.size()
		var src = GlobalValues.consumRewards.get(rewardItensConsum[chooseConsum])
		var srcImg = src[1]
		var srcDesc = src[2]
	
		container.get_child(1).get_node("Img").texture = load(srcImg)
		container.get_child(1).get_node("Desc").text = srcDesc
		container.get_child(1).get_node("Title").text = rewardItensConsum[chooseConsum]
		choosedRewards.append(GlobalValues.consumRewards.keys()[chooseConsum])
	else:
		container.get_child(1).hide()

func _physics_process(_delta):
	if stopPlayer:
		player.get_node("States/Move").hide()
		pointer.outInterface = false
		stopPlayer = false

func _on_Reward_pressed(type):
	if type == "ATK":
		var src = GlobalValues.atkPassivesReward.get(rewardItensATK[chooseAtk])
		GlobalValues.atkItens[rewardItensATK[chooseAtk]] = src
		print(GlobalValues.atkItens)
	elif type == "Consum":
		var src = GlobalValues.consumRewards.get(rewardItensConsum[chooseConsum])
		GlobalValues.consumItens[rewardItensConsum[chooseConsum]] = src
		print(GlobalValues.consumItens)

	player.get_node("States/Move").show()
	pointer.outInterface = true
	queue_free()

