extends Spatial

export (String,"Melee","Gun") var attackType
var animator
var goFight = false
var releasePointer = true
var actualEnemy
var scriptEnemy
var pointer

func _ready():
	animator = owner.get_node("AnimationTree")
	pointer = get_tree().get_nodes_in_group("Pointer")[0]

func _physics_process(delta):
	if goFight:
		start_fight()

func start_fight():
	var dist = owner.global_transform.origin.distance_to(actualEnemy.global_transform.origin)
	
	if releasePointer:
		pointer.global_transform.origin = actualEnemy.global_transform.origin
		pointer.hide()
		
		if attackType == "Melee":
			animator.set("parameters/States General/blend_amount",-1)
		else:
			animator.set("parameters/States General/blend_amount",1)
		
		if dist <= 1.5:
			owner.get_node("Base/Armature").rotation_degrees.y = 180
			owner.get_node("Base").look_at(actualEnemy.global_transform.origin,Vector3.UP)
			animator.set("parameters/move/blend_amount",0)
			owner.get_node("States/Move").hide()
			owner.get_node("Base/Armature/Skeleton/BoneAttachment/ProtonTrail").emit = true
			releasePointer = false
	
	if Input.is_action_just_pressed("Click") and !scriptEnemy.clicked:
		end_fight()
		yield(get_tree().create_timer(2),"timeout")
		if goFight:
			releasePointer = true

func end_fight():
	pointer.show()
	animator.set("parameters/States General/blend_amount",0)
	animator.set("parameters/Seek/seek_position",0)
	owner.get_node("Base/Armature").rotation_degrees.y = 0
	owner.get_node("States/Move").show()
	releasePointer = false

func set_melee_hitbox(stats):
	owner.get_node("Base/Armature/Skeleton/BoneAttachment/Sword/Area_Sword/CollisionShape").set_deferred("disabled",stats)

func _on_Damage_Zone_area_entered(area):
	if area.is_in_group("Enemy_Area") and !goFight:
		actualEnemy = area
		scriptEnemy = area.owner
		goFight = true
		releasePointer = true

func _on_Damage_Zone_area_exited(area):
	if area.is_in_group("Enemy_Area"):
		area = null
		goFight = false
		owner.get_node("Base/Armature/Skeleton/BoneAttachment/ProtonTrail").emit = false
