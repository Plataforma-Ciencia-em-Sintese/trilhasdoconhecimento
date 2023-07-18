extends Spatial

var orbType = ""
var cleanFX = load("res://Effects/Clean FX/Clean FX.efkefc")
var healFX = load("res://Effects/Heal Up/HealUp.efkefc")
var powerFX = load("res://Effects/Power Up/PowerUp.efkefc")
var play = false

func _physics_process(delta):
	if !play:
		var spawnFX
		if orbType == "Clean":
			$EffekseerEmitter.effect = cleanFX
		elif orbType == "Heal":
			$EffekseerEmitter.effect = healFX
			GlobalValues.lifeActual += 15
			get_tree().get_nodes_in_group("Player")[0].change_only_bar_value("Life")
		elif orbType == "Power":
			$EffekseerEmitter.effect = powerFX
			GlobalValues.energyActual += 10
			get_tree().get_nodes_in_group("Player")[0].change_only_bar_value("Energy")
		$EffekseerEmitter.play()
		
		
		play = true

func _on_Timer_timeout():
	queue_free()
