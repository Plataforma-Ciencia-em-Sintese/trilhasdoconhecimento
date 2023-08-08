extends Area

# Declara o node camera de onde surgira o raycast
export (NodePath) var camera

# Declara os valores de inicio e fim do raycast
var rayOrigin: Vector3
var rayEnd: Vector3

# Verifica se esta em algo que esconde pra nao mostrar o cursor
var insideAHider: bool = false

# Verifica se o jogador pode seguir ou nao o pointer
var isStopped: bool = false

# Informa se o mouse esta dentro ou fora da interface do jogo
var outInterface: bool = true

# Checa se tem alguma camera cinematica na cena
export var getCineCam: bool = false

func _ready():
	# Identifica quem é a camera do cenario
	camera = get_node(camera)
	if getCineCam:
		var cineCamera = get_tree().get_nodes_in_group("CineCamera")[0]
		cineCamera.connect("camera_activated",self,"cinematic_mode")

func _physics_process(_delta):
	# Rotaciona o objeto Arrow
	rotate_y(0.1)

func _input(event):
	# Caso o jogador clique com o mouse as acoes abaixo sao executadas
	if event is InputEventMouseButton:
		if event.is_action_pressed("Click") and outInterface:
			# Acessa os objetos fisicos 3D do cenario atual
			var space_state = get_world().direct_space_state
			# Coleta a posicao do mouse de acordo com o tamanho da viewport
			var mouse_pos = get_viewport().get_mouse_position()
			# Identifica de onde o raycast se origina
			# No caso a partir de onde o mouse esta interagindo dentro da camera
			rayOrigin = camera.project_ray_origin(mouse_pos)
			#Identifica de onde o raycast finaliza
			# No caso do ponto inicial do raycast ate o ponto de interacao do mouse multiplicado por n valor
			rayEnd = rayOrigin + camera.project_ray_normal(mouse_pos) * 2000
			# Cria o raycast em si com os valores de inicio e final
			var intersection = space_state.intersect_ray(rayOrigin,rayEnd)
			
			# Caso o mouse interaja com algum objeto
			# E se ele pertence a grupo onde o personagem pode andar
			# Muda o pointer para o local escolhido com o mouse
			if not intersection.empty() and intersection.collider.is_in_group("Walkable") and !isStopped:
				global_transform.origin = intersection.position

# Quando estiver dentro de algum objeto com dialogo,esconde
func _on_Pointer_body_entered(body):
	if body.is_in_group("NPC"):
		hide()
		insideAHider = true

# Quando estiver fora de algum objeto com dialogo,o script que escolhe
func _on_Pointer_body_exited(body):
	if body.is_in_group("NPC"):
		insideAHider = false

# Muda para a mesma posicao do jogador
func change_position():
	global_transform.origin = get_tree().get_nodes_in_group("Player")[0].global_transform.origin

func cinematic_mode(status):
	# Se o signal vindo da camera e iniciar ou terminar
	if status == "started":
		isStopped = true
	else:
		isStopped = false
