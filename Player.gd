extends CharacterBody2D

const SPEED = 150.0
@onready var dust_particles = $CPUParticles2D # Certifique-se que o nome está correto

func _ready():
	Objects.player = self

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction and Data.move == 1:
		velocity = direction * SPEED
		
		# Faz a poeira emitir
		dust_particles.emitting = true
		
		# Calcula o ângulo oposto ao movimento
		# O + PI (180 graus) faz com que aponte para trás
		dust_particles.rotation = direction.angle() + PI
		
	else:
		velocity = Vector2.ZERO
		dust_particles.emitting = false

	move_and_slide()
