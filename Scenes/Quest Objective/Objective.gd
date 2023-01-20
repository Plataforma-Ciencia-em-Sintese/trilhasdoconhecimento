extends Area

func change_state():
#	if QuestManager.isInQuest:
	#	QuestManager.change_checkbox()
	#	queue_free()
		pass
func _on_Objective_body_entered(body):
	if body.is_in_group("Player"):
		change_state()
