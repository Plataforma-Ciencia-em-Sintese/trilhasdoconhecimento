extends KinematicBody

const SPEED = 100.0
var path = []
var map
onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	call_deferred("setup_navserver")

func _physics_process(delta):
	$AnimationPlayer.play("WalkCycle_Boss01")
	var dir = Vector3()
	var step_size = delta * SPEED
	
	if path.size() > 0:
		var dest = path[0]
		dir = dest - translation
	
		if step_size > dir.length():
			step_size = dir.length()
			path.remove(0)
		
		move_and_slide(dir.normalized() * step_size)
#-----------------------------
	var target_global_pos = player.global_transform.origin
	var self_global_pos = global_transform.origin

	var y_distance = target_global_pos.y - self_global_pos.y
	var look_at_position = Vector3(target_global_pos.x, self_global_pos.y, target_global_pos.z)

	look_at(look_at_position, Vector3.UP)

func setup_navserver():
	map = NavigationServer.map_create()
	NavigationServer.map_set_up(map, Vector3.UP)
	NavigationServer.map_set_active(map,true)
	
	var region = NavigationServer.region_create()
	NavigationServer.region_set_transform(region, Transform())
	NavigationServer.region_set_map(region, map)
	
	var navigation_mesh = NavigationMesh.new()
	navigation_mesh = get_parent().get_node("NavigationMeshInstance").navmesh
	NavigationServer.region_set_navmesh(region,navigation_mesh)
	
	yield(get_tree(),"physics_frame")

func _on_NavTimer_timeout():
	var targetPoint = NavigationServer.map_get_closest_point_to_segment(map,translation,player.global_transform.origin)
	path = NavigationServer.map_get_path(map,translation,targetPoint,true)
	pass
