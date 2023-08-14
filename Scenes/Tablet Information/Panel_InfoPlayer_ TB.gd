extends Panel


func _ready():
	$TP_life.value = GlobalValues.lifeActual
	$TP_life/Label.text = str(GlobalValues.lifeActual) 
	
	$TP_Energy.value = GlobalValues.energyActual
	$TP_Energy/Label.text = str(GlobalValues.energyActual) 
	
	$TP_XP.value = GlobalValues.xpActual
	$TP_XP/Label.text = str(GlobalValues.xpActual) 
	
	$Name_Player.text = GlobalValues.nameChar

