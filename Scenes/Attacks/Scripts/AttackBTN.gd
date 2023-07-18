extends Button

#export (float) var cooldownValue = 1.0
#var startCooldown = false
export (String) var attackSource
export var followPlayer = false
var costPower = 0
var lvlToUnlock = 0
var unlocked = false
var attackScene
onready var rootPlayer = get_tree().get_nodes_in_group("Player")[0]
onready var pointer = get_tree().get_nodes_in_group("Pointer")[0]

#func _physics_process(delta):
#	if startCooldown:
#		$CoolDown.value -= cooldownValue * delta
#		if $CoolDown.value <= 0:
#			attackScene.queue_free()
#			startCooldown = false
#	else:
#		if $CoolDown.value < 100:
#			$CoolDown.value += cooldownValue * delta
#		else:
#			disabled = false

func _on_ATK_pressed():
	if rootPlayer.get_node("Status/Energy_Bar").value >= costPower * -1:
		if unlocked:
			pointer.outInterface = false
			var spwn = load(attackSource).instance()
			attackScene = spwn
			rootPlayer.get_node("Status").set_energy(costPower)
			if !followPlayer:
				var rootScene = get_parent().get_parent().get_parent().get_parent()
				rootScene.add_child(spwn)
				spwn.global_transform.origin = rootPlayer.global_transform.origin
				spwn.global_transform.basis = rootPlayer.get_node("Base/Skeleton").global_transform.basis
			else:
				rootPlayer.get_node("Base/Skeleton").add_child(spwn)
					
		#	if !startCooldown and $CoolDown.value >= 100:
		#		var spwn = load(attackSource).instance()
		#		attackScene = spwn
		#		if !followPlayer:
		#			var rootScene = get_parent().get_parent().get_parent().get_parent()
		#			rootScene.add_child(spwn)
		#			spwn.global_transform.origin = rootPlayer.global_transform.origin
		#			spwn.global_transform.basis = rootPlayer.get_node("Base/Skeleton").global_transform.basis
		#		else:
		#			rootPlayer.get_node("Base/Skeleton").add_child(spwn)
		#		disabled = true
		#		startCooldown = true
	else:
		$Low_Energy_Icon.show()
		$AnimationPlayer.play("Fade Battery")

func _on_ATK_mouse_entered():
	pointer.outInterface = false

func _on_ATK_mouse_exited():
	pointer.outInterface = true

func check_lvl():
	if GlobalValues.levelPlayer >= lvlToUnlock:
		unlocked = true
		$Lock_Icon.hide()
