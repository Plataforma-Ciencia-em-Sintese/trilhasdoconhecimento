extends Spatial

var paralizeTime = 5
var paralized = false
var stop = false
var spark

func _physics_process(delta):
	if is_visible_in_tree():
		if paralized:
			$Timer.start()
			spark = get_tree().get_nodes_in_group("BlueSpark")
			print("spark ",spark[0].get_child(0).name)
			owner.get_node("Enemy/ParalizedTxt").show()
			stop = true
			paralized = false
	
	if stop:
		owner.get_node("States/Battling").hide()
		
	if owner.get_node("Viewport/BarLife").value <= 0:
		print(spark, "krl")
		spark[0].get_child(1).stop()
		spark[0].get_child(0).queue_free()
		spark[0].get_child(1).queue_free()

func _on_Timer_timeout():
	owner.get_node("States/Battling").show()
	owner.get_node("Enemy/ParalizedTxt").hide()
	spark[0].get_child(1).stop()
	spark[0].get_child(0).queue_free()
	spark[0].get_child(1).queue_free()
	stop = false
	$Timer.stop()
	
