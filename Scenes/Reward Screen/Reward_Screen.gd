extends CanvasLayer

var actualItensAtk = []
var rewardItens = []
var choosedRewards = []
var id = 0
var chooseAtk

func _ready():
	# checa quais itens atualmente tem o jogador
	for i in GlobalValues.atkItens.size():
		actualItensAtk.append(GlobalValues.atkItens.keys()[i])
	
	print("o que tenho: ",actualItensAtk, " quant: ", actualItensAtk.size())
	
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
					rewardItens.append(GlobalValues.atkPassivesReward.keys()[i])
					print("item ", GlobalValues.atkPassivesReward.keys()[i]," nao tem")
					id = 0
					break
	else:
		for i in GlobalValues.atkPassivesReward.size():
			rewardItens.append(GlobalValues.atkPassivesReward.keys()[i])
	
	print("recompensas: ",rewardItens)
	
	# escolhe o ataque a ser mostrado pro jogador
	var container = $Container
	if rewardItens.size() > 0:
		randomize()
		chooseAtk = randi() % rewardItens.size()
		var src = GlobalValues.atkPassivesReward.get(rewardItens[chooseAtk])
		var srcImg = src[2]
		var srcDesc = src[3]
	
		container.get_child(0).get_node("Img").texture = load(srcImg)
		container.get_child(0).get_node("Desc").text = srcDesc
		container.get_child(0).get_node("Title").text = rewardItens[chooseAtk]
		choosedRewards.append(GlobalValues.atkPassivesReward.keys()[chooseAtk])
	else:
		container.get_child(0).hide()

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_select"):
		get_tree().reload_current_scene()

func _on_Reward_pressed(type):
	if type == "ATK":
		var src = GlobalValues.atkPassivesReward.get(rewardItens[chooseAtk])
		GlobalValues.atkItens[rewardItens[chooseAtk]] = src
		print(GlobalValues.atkItens)

