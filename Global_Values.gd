extends Node

# Seleção de personagens
var nameChar = "Bento"
var skinChar = "Normal"

# Controle de cena batalha/mundo real
var whiteScreen = false
var backToScene = ""
var sceneNameToQuestMNG = ""

# itens do inventário
var atkItens = {
	# chave: valor cooldown, cena do ataque, icone do ataque, seguir o jogador
	"Escudo de Energia": [50,"res://Scenes/Attacks/Energy Barrier/EnergyBarrier.tscn","res://Sprites/UI/Icons/Attacks/Force Field.png","O que escudo faz",true],
	"Ataque Meteoro": [50,"res://Scenes/Attacks/Meteor Attack/Meteor Attack.tscn","res://Sprites/UI/Icons/Attacks/Ray Explosion.png","meteoro caindo",false],
	"Aumento de velocidade": [50,"res://Scenes/Attacks/Speed Up/SpeedUp.tscn","res://Sprites/UI/Icons/Attacks/Speed.png","velocidade aumentada",true],
	"Laser Cibernetico": [50,"res://Scenes/Attacks/Laser/Laser.tscn","res://Sprites/UI/Icons/Attacks/Laser.png","laser do dbz",true]
}

# recompensas
var atkPassivesReward = {
	"Escudo de Energia": [50,"res://Scenes/Attacks/Energy Barrier/EnergyBarrier.tscn","res://Sprites/UI/Icons/Attacks/Force Field.png","O que escudo faz",true],
	"Ataque Meteoro": [50,"res://Scenes/Attacks/Meteor Attack/Meteor Attack.tscn","res://Sprites/UI/Icons/Attacks/Ray Explosion.png","meteoro caindo",false],
	"Aumento de velocidade": [50,"res://Scenes/Attacks/Speed Up/SpeedUp.tscn","res://Sprites/UI/Icons/Attacks/Speed.png","velocidade aumentada",true],
	"Laser Cibernetico": [50,"res://Scenes/Attacks/Laser/Laser.tscn","res://Sprites/UI/Icons/Attacks/Laser.png","laser do dbz",true]
}
