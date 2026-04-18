extends Control

@onready var card1 = $ColorRect
@onready var card2 = $ColorRect2
@onready var card3 = $ColorRect3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	rotate()
	
	var tween = create_tween()
	
	tween.tween_property(card1, "position:y", 120, 0.7).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(card1, "position:y", 320, 0.7).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	
	await get_tree().create_timer(0.2).timeout
	
	var tween2 = create_tween()
	
	tween2.tween_property(card2, "position:y", 120, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween2.tween_property(card2, "position:y", 180, 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	
	await get_tree().create_timer(0.2).timeout
	
	var tween3 = create_tween()
	
	tween3.tween_property(card3, "position:y", 120, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween3.tween_property(card3, "position:y", 180, 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func rotate() -> void:
	var tween = create_tween().set_loops()
	
	tween.tween_property(card1, "rotation", 0.1, 0.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(card1, "rotation", -0.1, 0.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)

func _on_color_rect_mouse_entered() -> void:
	var tween = create_tween()
	
	tween.tween_property(card1, "scale", Vector2(7,7), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)


func _on_color_rect_mouse_exited() -> void:
	var tween = create_tween().set_parallel()
	
	tween.tween_property(card1, "scale", Vector2(6,6), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)


func _on_color_rect_2_mouse_entered() -> void:
	var tween = create_tween()
	
	tween.tween_property(card2, "scale", Vector2(1.2,1.2), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)


func _on_color_rect_2_mouse_exited() -> void:
	var tween = create_tween().set_parallel()
	
	tween.tween_property(card2, "scale", Vector2(1,1), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
