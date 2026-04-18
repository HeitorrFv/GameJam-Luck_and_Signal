extends CharacterBody2D


const SPEED = 150.0

func _ready():
	Objects.player = self  # Registra este nó no Singleton global


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction and Data.move == 1:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()
