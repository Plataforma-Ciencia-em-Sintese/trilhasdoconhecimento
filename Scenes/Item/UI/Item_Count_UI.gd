extends CanvasLayer

# Contagem vem dos itens
var count = 0
# Limite vem do dialogic variavel
var limit = 0
# Nome da variavel a ser modificada
var questVariable : String
# Slot do painel de alerta
var alertPanel : String
# Mensagem para o alerta
var msg : String

func _ready():
	# Pega a variavel vinda do dialogic
	limit = Dialogic.get_variable(questVariable)
	$BG/Title.text = "Itens Pegos\n" + str(count) + " / " + limit

func change_ui(value):
	# Recebe o signal do item dizendo quanto e a quantidade e altera o valor no dialogic tambem
	count += value
	Dialogic.set_variable(questVariable,int(Dialogic.get_variable(questVariable)) - value)
	$BG/Title.text = "Itens Pegos\n" + str(count) + " / " + limit
	
	# Adianta o painel de alerta vindo presetado do global
	if int(Dialogic.get_variable(questVariable)) <= 0:
		var alert = load(alertPanel).instance()
		alert.txt = msg
		get_tree().root.call_deferred("add_child",alert)
		queue_free()
