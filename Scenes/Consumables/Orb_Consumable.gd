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
		elif orbType == "Power":
			$EffekseerEmitter.effect = powerFX

		$EffekseerEmitter.play()
		play = true

func _on_Timer_timeout():
	queue_free()
