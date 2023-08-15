extends CanvasLayer

# Coleta a resource da recompensa que vem do Global Quest
export (Array,Resource) var resourcesToShow
# Musica tema desse node
export (String) var musicName

func _ready():
# Toca a musica tema
	if musicName != "":
		GlobalMusicPlayer.play_sound("play_one",musicName)
	
	# Recebe as resources vindas do script global xp
	# Para cada uma, cria uma img, e ao final da animacao o canvas e destruido
	for i in resourcesToShow.size():
		var img = TextureRect.new()
		img.texture = resourcesToShow[i].icon
		img.expand = true
		img.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		img.size_flags_horizontal += TextureRect.SIZE_EXPAND
		img.size_flags_vertical += TextureRect.SIZE_EXPAND
		$BG/Skill_Container.add_child(img)

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
