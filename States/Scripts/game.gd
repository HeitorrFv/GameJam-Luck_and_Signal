extends Node2D

const Cena_chest = preload("res://Objects/bau.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_timer_timeout() -> void:
	var Chest = Cena_chest.instantiate()
	
	Chest.global_position.x = randf_range(-640,1280)
	Chest.global_position.y = randf_range(-360,720)
	
	add_child(Chest)
