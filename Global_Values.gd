extends Node

# Seleção de personagens
var nameChar = "Yara"
var skinChar = "Armadura"

# Controle de cena batalha/mundo real
var whiteScreen = false
var backToScene = ""
var sceneNameToQuestMNG = ""

#Medidor de xp do jogador
var levelPlayer = 1
var xpActual = 0

# Boost das armas
var lifeBoost = 0
var atkBoost = 0
var energyBoost = 0
var speedBoostWalk = 0
var speedBoostRun = 0

# Boost dos chips
var lifeBoostChip = 0
var atkBoostChip = 0
var energyBoostChip = 0
var speedBoostWalkChip = 0
var speedBoostRunChip = 0
var XPBoostChip = 0

# Boost das armas
var lifeBoostWeapon = 0
var atkBoostWeapon = 0
var energyBoostWeapon = 0
var speedBoostWalkWeapon = 0
var speedBoostRunWeapon = 0

# Valor ataque armas
var espadaValue = 35
var varinhaValue = 15
var manoplaValue = 50
var escudoValue = 5
var arcoValue = 10

# itens do inventário
var atkItens = {
	# chave: valor cooldown, cena do ataque, icone do ataque, seguir o jogador	
	
}

var atkItensSec = {
	# chave: valor cooldown, cena do ataque, icone do ataque, seguir o jogador	
	
}

var consumItens = {
	#chave: nome, sprite, descricao
	
}

var chipsItens = {
	
}

# o que ja ganhou
# quando pegar um novo item, ele deve ser add aqui
var atkPassivesReward = {
	"Escudo de Energia": ["res://Scenes/Attacks/Energy Barrier/EnergyBarrier.tscn","res://Sprites/UI/Icons/Attacks/Force Field.png","O que escudo faz",true,1],
	"Ataque Meteoro": ["res://Scenes/Attacks/Meteor Attack/Meteor Attack.tscn","res://Sprites/UI/Icons/Attacks/Ray Explosion.png","meteoro caindo",false,2],
	"Aumento de velocidade": ["res://Scenes/Attacks/Speed Up/SpeedUp.tscn","res://Sprites/UI/Icons/Attacks/Speed.png","velocidade aumentada",true,1],
	"Laser Cibernetico": ["res://Scenes/Attacks/Laser/Laser.tscn","res://Sprites/UI/Icons/Attacks/Laser.png","laser do dbz",true,2],
	"Raio Paralizante": ["res://Scenes/Attacks/Blue Sparkles/Blue Sparkles.tscn","res://Sprites/UI/Icons/Attacks/Sparkles.png","raio paralizador de inimigo",false,2],
	"Multiplas Balas": ["res://Scenes/Attacks/Projectiles/Special_Bullet_Spawner.tscn","res://Sprites/UI/Icons/Attacks/Bullets.png","balas multiplas",true,1],
	"Espada Giratoria": ["res://Scenes/Attacks/Sword Rotate/Sword_Area.tscn","res://Sprites/UI/Icons/Attacks/Sword Spin.png","espada giratoria",true,2],
	"Clone": ["res://Scenes/Attacks/Clone/Clone.tscn","res://Sprites/UI/Icons/Attacks/Clone.png","cria clone do char",false,1]
}

# o que ja ganhou
# apenas mudar o numero de itens que possui que ele aparece no inventario
var consumRewards = {
	"Orbe Life":["Heal","res://Sprites/UI/Icons/Consumiveis/Connect icon.png","Descricao vida",1],
	"Orbe Limpeza":["Clean","res://Sprites/UI/Icons/Consumiveis/Orb icon.png","Descricao limpeza",1],
	"Orbe Poder":["Power","res://Sprites/UI/Icons/Attacks/Force Field.png","Descricao poder de luta",1]
}

# o que ja ganhou
# quando pegar um novo item, ele deve ser add aqui
#ataque,life,energia,velocidade e xp
var chipsRewards = {
	"Chip de Conexão": ["res://Scenes/Chips/ChipConexao.tscn","res://Sprites/UI/Icons/Chips/Chip.png","Chip que conecta as coisas","Conexao"],
	"Chip de Recarga": ["res://Scenes/Chips/ChipRecarga.tscn","res://Sprites/UI/Icons/Chips/Chip.png","Chip que recarrega as coisas","Recarga"]
}

# Armas fixas
var weapons = {
	"Escudo": ["res://Sprites/UI/Icons/Weapons/Shield.png","Escudo do personagem",["Escudo de Energia","Ataque Meteoro","Aumento de velocidade"]],
	"Espada": ["res://Sprites/UI/Icons/Weapons/Sword.png","Espada laser star wars",["Laser Cibernetico","Raio Paralizante","Multiplas Balas"]],
	"Manopla": ["res://Sprites/UI/Icons/Weapons/Gauntlet.png","Manopla do Thanos",["Escudo de Energia","Clone","Espada Giratoria"]],
	"Varinha": ["res://Sprites/UI/Icons/Weapons/Wand.png","Varinha com poder supremo",["Escudo de Energia","Ataque Meteoro","Aumento de velocidade"]],
	"Arco": ["res://Sprites/UI/Icons/Inventário Icon/arco.png","Lança flechas nos inimigos",["Laser Cibernetico","Raio Paralizante","Multiplas Balas"]]
}
