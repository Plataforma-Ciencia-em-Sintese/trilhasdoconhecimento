extends Node

# Seleção de personagens
var nameChar = "Yara"
var skinChar = "Normal"

# Controle de cena batalha/mundo real
var whiteScreen = false
var backToScene = ""
var sceneNameToQuestMNG = ""

# itens do inventário
var atkItens = {
	# chave: valor cooldown, cena do ataque, icone do ataque, seguir o jogador	
}

var consumItens = {
	#chave: nome, sprite, descricao
}

# recompensas
var atkPassivesReward = {
	"Escudo de Energia": [50,"res://Scenes/Attacks/Energy Barrier/EnergyBarrier.tscn","res://Sprites/UI/Icons/Attacks/Force Field.png","O que escudo faz",true],
	"Ataque Meteoro": [50,"res://Scenes/Attacks/Meteor Attack/Meteor Attack.tscn","res://Sprites/UI/Icons/Attacks/Ray Explosion.png","meteoro caindo",false],
	"Aumento de velocidade": [50,"res://Scenes/Attacks/Speed Up/SpeedUp.tscn","res://Sprites/UI/Icons/Attacks/Speed.png","velocidade aumentada",true],
	"Laser Cibernetico": [50,"res://Scenes/Attacks/Laser/Laser.tscn","res://Sprites/UI/Icons/Attacks/Laser.png","laser do dbz",true],
	"Raio Paralizante": [50,"res://Scenes/Attacks/Blue Sparkles/Blue Sparkles.tscn","res://Sprites/UI/Icons/Attacks/Sparkles.png","raio paralizador de inimigo",false],
	"Multiplas Balas": [50,"res://Scenes/Attacks/Projectiles/Special_Bullet_Spawner.tscn","res://Sprites/UI/Icons/Attacks/Bullets.png","balas multiplas",true],
	"Espada Giratoria": [15,"res://Scenes/Attacks/Sword Rotate/Sword_Area.tscn","res://Sprites/UI/Icons/Attacks/Sword Spin.png","espada giratoria",true],
	"Clone": [15,"res://Scenes/Attacks/Clone/Clone.tscn","res://Sprites/UI/Icons/Attacks/Clone.png","cria clone do char",false]
}

var consumRewards = {
	"Orbe Life":["Heal","res://Sprites/UI/Icons/Consumiveis/Connect icon.png","Descricao vida"],
	"Orbe Limpeza":["Clean","res://Sprites/UI/Icons/Consumiveis/Orb icon.png","Descricao limpeza"],
	"Orbe Poder":["Power","res://Sprites/UI/Icons/Attacks/Force Field.png","Descricao poder de luta"]
}
