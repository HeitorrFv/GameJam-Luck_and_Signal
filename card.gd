extends Control

@onready var card1 = $ColorRect
@onready var card2 = $ColorRect2
@onready var card3 = $ColorRect3
@onready var blur = $"../Blur"

func _ready() -> void:
	blur.material.set_shader_parameter("lod", 0.0)
	
# Called when the node enters the scene tree for the first time.
func open() -> void:
		Data.CardOpen = 0
		
		var tween_intro = create_tween()
		tween_intro.tween_property(blur.material, "shader_parameter/lod", 2.5, 0.5)
		
		var tween = create_tween()
		
		tween.tween_property(card1, "position:y", 120, 0.7).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		tween.tween_property(card1, "position:y", 320, 0.7).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
		
		await get_tree().create_timer(0.2).timeout
		
		var tween2 = create_tween()
		
		tween2.tween_property(card2, "position:y", 120, 0.7).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		tween2.tween_property(card2, "position:y", 320, 0.7).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
		
		await get_tree().create_timer(0.2).timeout
		
		var tween3 = create_tween()
		
		tween3.tween_property(card3, "position:y", 120, 0.7).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		tween3.tween_property(card3, "position:y", 320, 0.7).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	
		rotate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Data.CardOpen == 1:
		open()

func rotate() -> void:
	var tween = create_tween().set_loops()
	
	tween.tween_property(card1, "rotation", 0.1, 0.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(card1, "rotation", -0.1, 0.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	
	var tween2 = create_tween().set_loops()
	
	tween2.tween_property(card2, "rotation", -0.1, 0.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween2.tween_property(card2, "rotation", 0.1, 0.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	
	var tween3 = create_tween().set_loops()
	
	tween3.tween_property(card3, "rotation", 0.1, 0.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween3.tween_property(card3, "rotation", -0.1, 0.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)

func _on_color_rect_mouse_entered() -> void:
	var tween = create_tween()
	
	tween.tween_property(card1, "scale", Vector2(7,7), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)


func _on_color_rect_mouse_exited() -> void:
	var tween = create_tween().set_parallel()
	
	tween.tween_property(card1, "scale", Vector2(6,6), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)


func _on_color_rect_2_mouse_entered() -> void:
	var tween = create_tween()
	
	tween.tween_property(card2, "scale", Vector2(7,7), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)


func _on_color_rect_2_mouse_exited() -> void:
	var tween = create_tween().set_parallel()
	
	tween.tween_property(card2, "scale", Vector2(6,6), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)


func _on_color_rect_3_mouse_entered() -> void:
	var tween = create_tween()
	
	tween.tween_property(card3, "scale", Vector2(7,7), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)


func _on_color_rect_3_mouse_exited() -> void:
	var tween = create_tween().set_parallel()
	
	tween.tween_property(card3, "scale", Vector2(6,6), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
