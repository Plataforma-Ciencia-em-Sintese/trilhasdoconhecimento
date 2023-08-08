extends Spatial

onready var anim = owner.get_node("AnimationPlayer")

func _physics_process(delta):
	if is_visible_in_tree():
		anim.play("Idle_Boss01")
		var target_global_pos = owner.player.global_transform.origin
		var self_global_pos = owner.global_transform.origin
		var look_at_position = Vector3(target_global_pos.x, self_global_pos.y, target_global_pos.z)
		owner.look_at(look_at_position, Vector3.UP)

