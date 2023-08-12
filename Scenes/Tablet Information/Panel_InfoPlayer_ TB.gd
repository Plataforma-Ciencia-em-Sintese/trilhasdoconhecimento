extends Panel


func _ready():
	$TP_life.value = GlobalValues.life
	$TP_life/Label.text = str(GlobalValues.life) 
	
	$TP_Energy.value = GlobalValues.energy
	$TP_Energy/Label.text = str(GlobalValues.energy) 
	
	$TP_XP.value = GlobalValues.xpActual
	$TP_XP/Label.text = str(GlobalValues.xpActual) 

