extends Node2D

@export var Enemy_scene: PackedScene

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_timer_timeout() -> void:
	spawn_enemy()

func spawn_enemy() -> void:
	var enemy = Enemy_scene.instantiate()
	
	add_child(enemy)
