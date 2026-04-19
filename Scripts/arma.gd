extends Area2D

# --- Configurações ---
@export var orbit_distance: float = 50.0  # Distância do player
@export var rotation_speed: float = 20.0  # Velocidade de acompanhamento (mais rápido é melhor)
@export var attack_arc: float = 160.0    # Quantos graus o arco de ataque cobre
@export var windup_arc: float = -40.0     # Quantos graus ela recua antes de bater
@export var attack_speed: float = 0.2    # Tempo total do golpe rápido
@export var windup_speed: float = 0.1    # Tempo da antecipação

# --- Estados Internos ---
var is_attacking: bool = false
var current_angle: float = 0.0 # Ângulo atual (em radianos) onde a arma está
var attack_swing_sign: int = 1  # 1 para sentido horário, -1 para anti-horário

# Referência ao Player (para economizar get_parent())
@onready var player: Node2D = get_parent()

func _ready() -> void:
	# Garante que a Area2D não gire junto com o pai (se o pai girar)
	set_as_top_level(true)

var tempo_ultimo_hit: float = 0.0
var intervalo_dano: float = 0.5 # Meio segundo entre hits

func _physics_process(delta: float) -> void:
	if is_attacking:
		tempo_ultimo_hit += delta
		
		if tempo_ultimo_hit >= intervalo_dano:
			var bodies = get_overlapping_bodies()
			for body in bodies:
				if body.has_method("hit"):
					body.hit(Objects.player.global_position)
					body.Life -= 10
			
			# Reseta o tempo
			tempo_ultimo_hit = 0.0
	else:
		# Reseta o tempo quando parar de atacar para o próximo ataque ser instantâneo
		tempo_ultimo_hit = intervalo_dano
	# Usamos _physics_process para sincronizar melhor com o movimento do player
	if not is_attacking:
		update_idle_orbit(delta)
	else:
		update_position_from_angle()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and not is_attacking:
			perform_arc_attack()

func update_idle_orbit(delta: float) -> void:
	# 1. Pega o ângulo em direção ao mouse
	var mouse_pos = get_global_mouse_position()
	var target_dir = (mouse_pos - player.global_position).normalized()
	var target_angle = target_dir.angle()
	
	# 2. Suaviza a rotação (lerp do ângulo)
	current_angle = lerp_angle(current_angle, target_angle, rotation_speed * delta)
	
	# 3. Atualiza a posição e rotação visual
	update_position_from_angle()

# Função auxiliar para colocar a arma no ângulo correto
func update_position_from_angle() -> void:
	# Posição: Usamos cosseno para X e seno para Y para orbitar
	var offset = Vector2(cos(current_angle), sin(current_angle)) * orbit_distance
	global_position = player.global_position + offset
	
	# Rotação Visual: A arma aponta para fora do centro da órbita
	global_rotation = current_angle

func perform_arc_attack() -> void:
	is_attacking = true
	
	# Inverte a direção do balanço a cada golpe
	attack_swing_sign *= -1 
	
	# 1. Pegamos a direção REAL do mouse no momento do clique como o "centro"
	var mouse_dir = (get_global_mouse_position() - player.global_position).normalized()
	var center_angle = mouse_dir.angle()
	
	# 2. Convertemos os arcos para radianos
	var half_arc = deg_to_rad(attack_arc / 2.0)
	var rad_windup = deg_to_rad(windup_arc)
	
	# 3. Calculamos os pontos:
	# Start: Onde o golpe começa (um lado do arco)
	# End: Onde o golpe termina (outro lado do arco)
	# Windup: Um pouco atrás do ponto de início
	var start_angle = center_angle - (half_arc * attack_swing_sign)
	var end_angle = center_angle + (half_arc * attack_swing_sign)
	var windup_pos = start_angle - (rad_windup * attack_swing_sign)
	
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	
	# --- PASSO 1: Preparação rápida ---
	# Coloca a arma na posição de início do arco instantaneamente ou bem rápido
	tween.tween_property(self, "current_angle", windup_pos, 0.05)
	
	# --- PASSO 2: Antecipação (Recua mais um pouco) ---
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "current_angle", start_angle, windup_speed)
	
	# --- PASSO 3: O Swing (Atravessa o centro onde o mouse estava) ---
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "current_angle", end_angle, attack_speed)
	
	tween.finished.connect(func(): is_attacking = false)
