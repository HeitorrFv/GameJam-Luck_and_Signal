extends CharacterBody2D

@export var Speed = 80
@export var Life = 30
@export var drop1: PackedScene
var alvo = 1

@onready var player_dir = (Objects.tower.global_position - global_position).normalized()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# ... suas variáveis existentes ...
# ... suas variáveis existentes ...
var knockback_force = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if alvo == 1:
		player_dir = (Objects.tower.global_position - global_position).normalized()
	elif alvo == 2:
		player_dir = (Objects.player.global_position - global_position).normalized()
	
	# O movimento normal
	velocity = player_dir * Speed
	
	# Soma a força do empurrão à velocidade
	velocity += knockback_force
	
	# Reduz o empurrão gradualmente (atrito)
	knockback_force = lerp(knockback_force, Vector2.ZERO, 0.1) # Ajuste 0.1 para mais/menos deslize

	move_and_slide()
	
func _process(delta: float) -> void:
	if Life <= 0:
		if drop1:
			var potion = drop1.instantiate()
			
			# 1. PRIMEIRO: Define a posição (global_position só funciona após entrar na árvore, 
			# então usamos 'position' ou definimos logo após add_child com cuidado)
			potion.position = self.global_position 
			
			# 2. DEPOIS: Adiciona ao mapa
			get_parent().add_child(potion)
			
			# 3. GARANTIA: Força a posição global caso o spawner esteja deslocado
			potion.global_position = self.global_position
			
		queue_free()

# Altere sua função hit para receber a posição de quem bateu
func hit(source_position: Vector2) -> void:
	var push_direction = (global_position - source_position).normalized()
	knockback_force = push_direction * 300 # 300 é a força do impacto


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		alvo = 2


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		alvo = 1


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Data.Health -= 5
