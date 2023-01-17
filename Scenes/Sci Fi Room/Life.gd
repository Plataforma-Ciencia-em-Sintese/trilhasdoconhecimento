extends Spatial

var health := 100.0
var max_health := 100.0
var health_recovery := 1

var energia := 100.0
var max_energia := 100.0
var energia_recovery := 1.0

signal player_stats_changed


func _ready():
	emit_signal("player_stats_changed", self)

func _process(delta: float) -> void:
	var new_energia = min(energia + energia_recovery * delta, max_energia)
	if new_energia != energia:
		energia = new_energia
		emit_signal("player_stats_changed", self)
		
	var new_health = min(health + health_recovery * delta, max_health)
	if new_health != health:
		health = new_health
		emit_signal("player_stats_changed", self)
		
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Power"):
		if energia >= 10:
			energia = energia - 10
			emit_signal("player_stats_changed", self)
			# teste, essa parte é pra ser colocada quando o player for atacado
	if Input.is_action_just_pressed("Perdevida"):
		if health >= 10:
			health = health - 10
			emit_signal("player_stats_changed", self)

