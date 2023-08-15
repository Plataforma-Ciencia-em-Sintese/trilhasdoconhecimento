extends Area

var rotX : float
var rotY : float
var rotZ : float
var size : float
var trans : float
var speed : int = 1
export (Vector3) var direction

func _ready():
	randomize()
	rotX = rand_range(1,2)
	rotY = rand_range(1,2)
	rotZ = rand_range(1,2)
	size = rand_range(0.1,1)
	trans = rand_range(3,50)
	global_scale(Vector3(size,size,size))

func _process(delta):
	$Cube_Float.rotate_x(rotX * delta)
	$Cube_Float.rotate_y(rotY * delta)
	$Cube_Float.rotate_z(rotZ * delta)
	
	translate(Vector3(direction.x * trans,0,direction.z * trans) * speed * delta) 

