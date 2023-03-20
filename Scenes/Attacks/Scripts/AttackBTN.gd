extends Button

export (float) var cooldownValue = 1
export (String) var attackSource
export var followPlayer = false
var startCooldown = false
var attackScene
onready var pointer = get_tree().get_nodes_in_group("Pointer")[0]

func _physics_process(delta):
	if startCooldown:
		$CoolDown.value -= cooldownValue * delta
		if $CoolDown.value <= 0:
			attackScene.queue_free()
			startCooldown = false
	else:
		if $CoolDown.value < 100:
			$CoolDown.value += cooldownValue * delta
		else:
			disabled = false
			
func _on_ATK_pressed():
	pointer.outInterface = false
	if !startCooldown and $CoolDown.value >= 100:
		var spwn = load(attackSource).instance()
		attackScene = spwn
		if !followPlayer:
			owner.owner.add_child(spwn)
			spwn.global_transform.origin = owner.global_transform.origin
			spwn.global_transform.basis = owner.get_node("Base/Armature").global_transform.basis
			
		else:
			owner.get_node("Base/Armature").add_child(spwn)
		disabled = true
		startCooldown = true

func _on_ATK_mouse_entered():
	pointer.outInterface = false

func _on_ATK_mouse_exited():
	pointer.outInterface = true
