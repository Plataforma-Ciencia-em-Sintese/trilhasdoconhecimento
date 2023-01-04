extends Spatial

export (String) var missionName
export (String,MULTILINE) var missionDesc
export (Dictionary) var steps
export (Dictionary) var rewards
var questScene #Cena global

func set_quest():
	QuestManager.start_quest(missionName,missionDesc,steps)
	QuestManager.isInQuest = true
