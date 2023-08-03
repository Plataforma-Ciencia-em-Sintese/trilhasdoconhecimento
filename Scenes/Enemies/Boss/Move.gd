extends Spatial

var SPEED = 100.0
var path = []
var map
var pursuit = false

func _ready():
	call_deferred("setup_navserver")

func _physics_process(delta):
	if is_visible_in_tree():
		pursuit = true
		owner.get_node("AnimationPlayer").play("WalkCycle_Boss01")
		var dir = Vector3()
		var step_size = delta * SPEED
		
		if path.size() > 0:
			var dest = path[0]
			dir = dest - owner.global_transform.origin
		else:
			dir = owner.player.global_transform.origin
		
		if step_size > dir.length():
			step_size = dir.length()
			path.remove(0)
		
		owner.move_and_slide(dir.normalized() * step_size)
	#-----------------------------
		var target_global_pos = owner.player.global_transform.origin
		var self_global_pos = owner.global_transform.origin
		var look_at_position = Vector3(target_global_pos.x, self_global_pos.y, target_global_pos.z)
		owner.look_at(look_at_position, Vector3.UP)

#		var look = owner.global_transform.looking_at(player.global_transform.origin,Vector3.UP)
#		var rot = look.basis
#		owner.global_transform.basis.slerp(rot,0.001)
	else:
		pursuit = false

func setup_navserver():
	map = NavigationServer.map_create()
	NavigationServer.map_set_up(map, Vector3.UP)
	NavigationServer.map_set_active(map,true)
	
	var region = NavigationServer.region_create()
	NavigationServer.region_set_transform(region, Transform())
	NavigationServer.region_set_map(region, map)
	
	var navigation_mesh = NavigationMesh.new()
	navigation_mesh = owner.owner.get_node("NavigationMeshInstance").navmesh
	NavigationServer.region_set_navmesh(region,navigation_mesh)
	
	yield(get_tree(),"physics_frame")

func _on_NavTimer_timeout():
	if pursuit:
		var targetPoint = NavigationServer.map_get_closest_point_to_segment(map,owner.global_transform.origin,owner.player.global_transform.origin)
		path = NavigationServer.map_get_path(map,owner.global_transform.origin,targetPoint,true)
		
