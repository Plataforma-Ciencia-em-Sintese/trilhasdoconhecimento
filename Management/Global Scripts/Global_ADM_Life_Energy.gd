extends Node

signal setLife(value)
signal setEnergy(value)

func life_changer(value):
	GlobalValues.lifeActual += value
	emit_signal("setLife",value)

func energy_changer(value):
	GlobalValues.energyActual += value
	emit_signal("setEnergy",value)
