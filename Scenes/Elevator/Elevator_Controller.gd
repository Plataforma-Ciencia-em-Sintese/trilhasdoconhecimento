extends Area

# Fases pre dipsostas para selecionar
export (String,"Cyberspace","Primeiro Andar","Segundo Andar") var sceneToGo
# Cenas disponiveis
# A ordem da array e manual
export (Array,String) var scenes
# Serve para bloquear a entrada white
# A cena e global white transition
export (bool) var activatedFade
# Resource contendo os efeitos sonoros do inventario
export (Resource) var sfxResource

func _ready():
	if activatedFade:
		WhiteTransition.start_transition("fadeout")

func _on_Elevator_Controller_body_entered(body):
	if body.is_in_group("Player"):
		$AnimationPlayer.play("Open")
		GlobalMusicPlayer.play_sound("play_one",sfxResource.sfx["PortaAutomaticaAbrindo"])
		# Trava o pointer dentro do elevador pro player ir ate la
		var pointer = get_tree().get_nodes_in_group("Pointer")[0]
		pointer.global_transform.origin = $Model.global_transform.origin
		pointer.isStopped = true
		yield(get_tree().create_timer(1),"timeout")
		$AnimationPlayer.play("Close")
		GlobalMusicPlayer.play_sound("play_one",sfxResource.sfx["PortaAutomaticaFechando"])
		WhiteTransition.start_transition("fadein")
		yield(get_tree().create_timer(2),"timeout")
		match sceneToGo:
			"Cyberspace":
				get_tree().change_scene_to(load(scenes[0]))
			"Primeiro Andar":
				get_tree().change_scene_to(load(scenes[1]))
			"Segundo Andar":
				get_tree().change_scene_to(load(scenes[2]))

