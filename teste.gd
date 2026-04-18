extends Node2D

var pressed = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pressed:
		# Makes the node (e.g., a Sprite or gun) look at the global mouse position
		look_at(get_global_mouse_position())

# Connect this to the button's "button_down" signal
func _on_button_button_down() -> void:
	pressed = true

# Connect this to the button's "button_up" signal
func _on_button_button_up() -> void:
	pressed = false
