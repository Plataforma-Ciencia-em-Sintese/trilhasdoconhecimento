extends Spatial

onready var anim = owner.get_node("AnimationPlayer")
onready var player = get_tree().get_nodes_in_group("Player")[0]

func _physics_process(delta):
	if is_visible_in_tree():
		anim.play("Idle_Boss01")
		
		var target_global_pos = player.global_transform.origin
		var self_global_pos = owner.global_transform.origin

		var y_distance = target_global_pos.y - self_global_pos.y
		var look_at_position = Vector3(target_global_pos.x, self_global_pos.y, target_global_pos.z)

		owner.look_at(look_at_position, Vector3.UP)
