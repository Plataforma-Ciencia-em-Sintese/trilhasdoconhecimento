extends ColorRect

 


func _on_Life_player_stats_changed(var player) -> void:
	$bar.rect_size.y = 72 * player.energia / player.max_energia
