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

# Valor base jogador
var atkMain = 6
var atkSec = 6
var speed = 4
var life = 30
var energy = 30
var xpChip = 0

# Valores atuais jogador
var atkMainActual = 0.0
var atkSecActual = 0.0
var speedActual = 0.0
var lifeActual = 0.0
var energyActual = 0.0

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
	#[source ataque,icone do ataque,descricao,ficar dentro do player,level de desbloqueio,custo de uso]
	"Escudo de Energia": ["res://Scenes/Attacks/Energy Barrier/EnergyBarrier.tscn","res://Sprites/UI/Icons/Attacks/Atk2_teste.png","O que escudo faz",true,1,-3],
	"Ataque Meteoro": ["res://Scenes/Attacks/Meteor Attack/Meteor Attack.tscn","res://Sprites/UI/Icons/Attacks/Atk2_teste.png","meteoro caindo",false,2,-3],
	"Aumento de velocidade": ["res://Scenes/Attacks/Speed Up/SpeedUp.tscn","res://Sprites/UI/Icons/Attacks/Atk2_teste.png","velocidade aumentada",true,1,-3],
	"Laser Cibernetico": ["res://Scenes/Attacks/Laser/Laser.tscn","res://Sprites/UI/Icons/Attacks/Atk2_teste.png","laser do dbz",true,2,-3],
	"Raio Paralizante": ["res://Scenes/Attacks/Blue Sparkles/Blue Sparkles.tscn","res://Sprites/UI/Icons/Attacks/Atk2_teste.png","raio paralizador de inimigo",false,2,-3],
	"Multiplas Balas": ["res://Scenes/Attacks/Projectiles/Special_Bullet_Spawner.tscn","res://Sprites/UI/Icons/Attacks/Atk2_teste.png","balas multiplas",true,1,-3],
	"Espada Giratoria": ["res://Scenes/Attacks/Sword Rotate/Sword_Area.tscn","res://Sprites/UI/Icons/Attacks/Atk2_teste.png","espada giratoria",true,2,-3],
	"Clone": ["res://Scenes/Attacks/Clone/Clone.tscn","res://Sprites/UI/Icons/Attacks/Atk2_teste.png","cria clone do char",false,1,-3]
}

# o que ja ganhou
# apenas mudar o numero de itens que possui que ele aparece no inventario
var consumRewards = {
	#[tipo item,icone,descricao,quantidade]
	"Orbe Life":["Heal","res://Sprites/UI/Icons/Icons_Invent/consum_icon.png","Descricao vida",1],
	"Orbe Limpeza":["Clean","res://Sprites/UI/Icons/Icons_Invent/consum_icon_vazio.png","Descricao limpeza",1],
	"Orbe Poder":["Power","res://Sprites/UI/Icons/Icons_Invent/consum_icon_vazio.png","Descricao poder de luta",1]
}

# o que ja ganhou
# quando pegar um novo item, ele deve ser add aqui
#ataque,life,energia,velocidade e xp
var chipsRewards = {
	#[source,icone,descricao,tipo item]
	"Chip de Conexão": ["res://Scenes/Chips/ChipConexao.tscn","res://Sprites/UI/Icons/Icons_Invent/Chips_Icon.png","Chip que conecta as coisas","Conexao"],
	"Chip de Recarga": ["res://Scenes/Chips/ChipRecarga.tscn","res://Sprites/UI/Icons/Icons_Invent/Chips_Icon_vazio.png","Chip que recarrega as coisas","Recarga"]
}

# Armas fixas
var weapons = {
	#[icone,descricao,[nome itens ataque]]
	"Escudo": ["res://Sprites/UI/Icons/Weapons/Shield.png","Escudo do personagem",["Escudo de Energia","Ataque Meteoro","Aumento de velocidade"]],
	"Espada": ["res://Sprites/UI/Icons/Icons_Invent/armas_icons/espada_arma.png","Espada laser star wars",["Laser Cibernetico","Raio Paralizante","Multiplas Balas"]],
	"Manopla": ["res://Sprites/UI/Icons/Icons_Invent/armas_icons/manopola_arma.png","Manopla do Thanos",["Escudo de Energia","Clone","Espada Giratoria"]],
	"Varinha": ["res://Scenes/Inventory/Resource Inventory/Weapons/Varinha.tres"],
	"Arco": ["res://Sprites/UI/Icons/Icons_Invent/armas_icons/arco_arma.png","Lança flechas nos inimigos",["Laser Cibernetico","Raio Paralizante","Multiplas Balas"]]
}
#"Varinha": ["res://Sprites/UI/Icons/Icons_Invent/armas_icons/varinha_arma.png","Varinha com poder supremo",["Escudo de Energia","Ataque Meteoro","Aumento de velocidade"]],
