extends CharacterBody2D

@export var Speed = 80
var alvo = 1

var player_dir = (Objects.tower.global_position - global_position).normalized()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if alvo == 1:
		player_dir = (Objects.tower.global_position - global_position).normalized()
	elif alvo == 2:
		player_dir = (Objects.player.global_position - global_position).normalized()
	
	velocity = player_dir * Speed

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		alvo = 2


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		alvo = 1


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Data.Health -= 5
