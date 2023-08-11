extends Camera

# Define se a camera se move sozinha ou com acao humana
export (String, "Automatic","Trigger") var camMovement
# Dicionario com as infos da camera
# 0 - Pra quem deve olhar
# 1 - Qual ancora deve ir
# 2 - Tempo de ativaçao
# 3 - Tempo de ida ate a ancora (lerp)
# 4 - Tempo de olhar para o alvo (lerp)
# 5 - Texto da etapa
export (Dictionary) var infos
# Desativa a cinematica caso marque
export (bool) var deactivated = false
# Nodes de ancora e alvo
var targetToLook : Node
var posToLook : Node
# Marca a posiçao atual da camera
var actualPos = 0
# Nodes da cena
onready var descriptionTxt : Node = $CanvasLayer/BG_Text/Desc
onready var continueButton : Node = $CanvasLayer/BG_Text/BTN_Continue
onready var canvasLyr : Node = $CanvasLayer
onready var timerNode :  Node = $Timer
onready var cameraMain : Node = get_tree().get_nodes_in_group("Camera")[0]
# Signal que informa quando comecou e quando terminou a cinematica
signal camera_activated(status)

func _ready():
	if !deactivated:
		# Chama o signal e preseta os nodes no dicionario inicial
		emit_signal("camera_activated","started")
		canvasLyr.show()
		cameraMain.current = false
		current = true
		targetToLook = get_node(infos[actualPos][0])
		posToLook = get_node(infos[actualPos][1])
		descriptionTxt.text = infos[actualPos][5]
		
		# Se for sozinha, o node timer ativa as etapas
		# Senao o botao de continuar e mostrado
		if camMovement == "Automatic":
			timerNode.start(infos[actualPos][2])
			continueButton.hide()
		else:
			continueButton.show()
	else:
		canvasLyr.hide()
		cameraMain.current = true
		current = false

func _process(delta):
	if !deactivated:
		cine_camera(targetToLook,posToLook)

func cine_camera(target,pos):
#	Olha para o alvo e vai ate a ancora com lerp
	var look = global_transform.looking_at(target.global_transform.origin,Vector3.UP)
	var rot = look.basis
	global_transform.basis = global_transform.basis.slerp(rot,infos[actualPos][4])
	global_transform.origin = lerp(global_transform.origin,pos.global_transform.origin,infos[actualPos][3])

func _on_Timer_timeout():
	# Se o tempo da etapa acaba, aumenta a etapa atual e procura os novos nodes
	if actualPos < infos.size()-1:
		actualPos += 1
		timerNode.start(infos[actualPos][2])
		if infos[actualPos][0] != "":
			targetToLook = get_node(infos[actualPos][0])
		if infos[actualPos][1] != "":
			posToLook = get_node(infos[actualPos][1])
		if infos[actualPos][5] != "":
			descriptionTxt.text = infos[actualPos][5]
	else:
		# Senao acaba e manda o signal pros objetos da cena ficarem sabendo
		emit_signal("camera_activated","ended")
		cameraMain.current = true
		queue_free()
			
func _on_BTN_Continue_pressed():
	# Mesma logica do timeout event
	if actualPos < infos.size()-1:
		actualPos += 1
		if infos[actualPos][0] != "":
			targetToLook = get_node(infos[actualPos][0])
		if infos[actualPos][1] != "":
			posToLook = get_node(infos[actualPos][1])
		if infos[actualPos][5] != "":
			descriptionTxt.text = infos[actualPos][5]
	else:
		emit_signal("camera_activated","ended")
		cameraMain.current = true
		queue_free()
