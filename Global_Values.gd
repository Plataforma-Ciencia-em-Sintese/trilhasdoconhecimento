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

var chipsItens = {
	
}

# recompensas
var atkPassivesReward = {
	"Escudo de Energia": ["res://Scenes/Attacks/Energy Barrier/EnergyBarrier.tscn","res://Sprites/UI/Icons/Attacks/Force Field.png","O que escudo faz",true],
	"Ataque Meteoro": ["res://Scenes/Attacks/Meteor Attack/Meteor Attack.tscn","res://Sprites/UI/Icons/Attacks/Ray Explosion.png","meteoro caindo",false],
	"Aumento de velocidade": ["res://Scenes/Attacks/Speed Up/SpeedUp.tscn","res://Sprites/UI/Icons/Attacks/Speed.png","velocidade aumentada",true],
	"Laser Cibernetico": ["res://Scenes/Attacks/Laser/Laser.tscn","res://Sprites/UI/Icons/Attacks/Laser.png","laser do dbz",true],
	"Raio Paralizante": ["res://Scenes/Attacks/Blue Sparkles/Blue Sparkles.tscn","res://Sprites/UI/Icons/Attacks/Sparkles.png","raio paralizador de inimigo",false],
	"Multiplas Balas": ["res://Scenes/Attacks/Projectiles/Special_Bullet_Spawner.tscn","res://Sprites/UI/Icons/Attacks/Bullets.png","balas multiplas",true],
	"Espada Giratoria": ["res://Scenes/Attacks/Sword Rotate/Sword_Area.tscn","res://Sprites/UI/Icons/Attacks/Sword Spin.png","espada giratoria",true],
	"Clone": ["res://Scenes/Attacks/Clone/Clone.tscn","res://Sprites/UI/Icons/Attacks/Clone.png","cria clone do char",false]
}

var consumRewards = {
	"Orbe Life":["Heal","res://Sprites/UI/Icons/Consumiveis/Connect icon.png","Descricao vida"],
	"Orbe Limpeza":["Clean","res://Sprites/UI/Icons/Consumiveis/Orb icon.png","Descricao limpeza"],
	"Orbe Poder":["Power","res://Sprites/UI/Icons/Attacks/Force Field.png","Descricao poder de luta"]
}

var chipsRewards = {
	"Chip de Conexão": ["res://Scenes/Attacks/Energy Barrier/EnergyBarrier.tscn","res://Sprites/UI/Icons/Chips/Chip.png","Chip que conecta as coisas","Conexao"],
	"Chip de Recarga": ["res://Scenes/Attacks/Energy Barrier/EnergyBarrier.tscn","res://Sprites/UI/Icons/Chips/Chip.png","Chip que recarrega as coisas","Recarga"],
}

var weapons = {
	"Escudo": ["res://Sprites/UI/Icons/Weapons/Shield.png","Escudo do personagem"],
	"Espada Laser": ["res://Sprites/UI/Icons/Weapons/Sword.png","Espada laser star wars"],
	"Manopla": ["res://Sprites/UI/Icons/Weapons/Gauntlet.png","Manopla do Thanos"],
	"Varinha": ["res://Sprites/UI/Icons/Weapons/Wand.png","Varinha com poder supremo"],
	"Arco": ["res://Sprites/UI/Icons/Weapons/Bow.png","Lança flechas nos inimigos"]
}
