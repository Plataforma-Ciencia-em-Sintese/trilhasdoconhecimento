extends Resource
class_name WeaponsValues

var type = "Weapon"
export(Texture) var icon
export(String) var name = ""
export(String,MULTILINE) var description = ""
export(String,"+","-","N/D") var lifeOperation
export (int) var numLife = 0
export (int) var denLife = 0
export(String,"+","-","N/D") var energyOperation
export (int) var numEnergy = 0
export (int) var denEnergy = 0
export(String,"+","-","N/D") var speedOperation
export (int) var numSpeed = 0
export (int) var denSpeed = 0
export(String,"+","-","N/D") var atkOperation
export (int) var numATK = 0
export (int) var denATK = 0
export(Array,Resource) var skillsInOrder
