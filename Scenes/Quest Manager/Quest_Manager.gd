extends Spatial

var isInQuest = false
var checkbox = load("res://Scenes/Quest Manager/CheckBox.tscn")
var rewardIMG = load("res://Scenes/Quest Manager/Reward_Icon.tscn")
var objective = load("res://Scenes/Quest Objective/Objective.tscn")
var missionName = ""
var actualStep = 0
var totalSteps = 0
var show = false


onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	$UI.hide()
	$Buttons_Diary/BT_Close.hide()
	$Buttons_Diary.hide()

#func _physics_process(delta):
#	print(actualStep)

func start_quest(missionID,missionDesc,steps):
	$UI/BG_Mission_Title/Title_Mission.text = missionID
	$UI/Mission_Desc.text = missionDesc
	$Buttons_Diary.show()
	missionName = missionID
	
	var newObjective = objective.instance()
	get_node("/root/Scifi_Stage/Quest_Objectives").add_child(newObjective)
	newObjective.translation= get_node("/root/Scifi_Stage/Quest_Objectives").get_node(missionName).get_child(actualStep).translation
	print(missionName)
	print(get_node("/root/Scifi_Stage/Quest_Objectives").get_node(missionName))
	
	for i in steps.size():
		var chk = checkbox.instance()
		$UI/Scroll_Steps/Checklist_Box.add_child(chk)
		chk.text = steps.keys()[i]
		totalSteps += 1

func change_checkbox():
	$UI/Scroll_Steps/Checklist_Box.get_child(actualStep).pressed = true
	
	if actualStep < totalSteps - 1:
		actualStep += 1
		yield(get_tree().create_timer(0.1), "timeout")
		var newObjective = objective.instance()
		get_node("/root/Scifi_Stage/Quest_Objectives").add_child(newObjective)
		newObjective.translation = get_node("/root/Scifi_Stage/Quest_Objectives").get_node(missionName).get_child(actualStep).translation	
	else:
		Dialogic.set_variable(missionName,"completed")
		
func finish_quest():
	for i in $UI/Scroll_Steps/Checklist_Box.get_children():
		i.queue_free()
		
	$UI.hide()
	$Buttons_Diary/BT_Close.hide()
	$Buttons_Diary.hide()

func _on_BT_Open_pressed():
	$UI.show()
	$Buttons_Diary/BT_Open.hide()
	$Buttons_Diary/BT_Close.show()
	player.get_node("States/Move").hide()
	player.get_node("States/Talking").show()

func _on_BT_Close_pressed():
	$UI.hide()
	$Buttons_Diary/BT_Open.show()
	$Buttons_Diary/BT_Close.hide()
	player.get_node("States/Move").show()
	player.get_node("States/Talking").hide()
