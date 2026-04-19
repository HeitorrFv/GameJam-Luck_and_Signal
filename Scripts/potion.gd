extends Area2D

var sendo_coletado = false

func _ready() -> void:
	set_as_top_level(true) # Importante para não bugar a posição global
	efeito_drop()

func efeito_drop() -> void:
	var tween = create_tween()
	var posicao_final = global_position + Vector2(randf_range(-20, 20), 0)
	var altura_pulo = global_position + Vector2(0, -40)
	
	tween.set_parallel(false)
	tween.tween_property(self, "global_position", altura_pulo, 0.3).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", posicao_final, 0.4).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)

# Conecte o sinal body_entered da sua Area2D a esta função
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not sendo_coletado:
		coletar_item()

func coletar_item() -> void:
	sendo_coletado = true
	var destino = Data.item1 
	
	if destino != null:
		monitoring = false
		
		# --- LÓGICA DE CONVERSÃO DE COORDENADAS ---
		var canvas_pos = destino.get_global_transform_with_canvas().origin
		var centro_botao = canvas_pos + (destino.size / 2)
		var posicao_final_mundo = get_viewport().get_canvas_transform().affine_inverse() * centro_botao
		# ------------------------------------------

		var tween = create_tween()
		tween.set_parallel(true)
		
		# Agora usamos a posição convertida para o mundo
		tween.tween_property(self, "global_position", posicao_final_mundo, 0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
		tween.tween_property(self, "scale", Vector2(0.2, 0.2), 0.5) # Diminuir costuma ficar melhor que aumentar
		
		tween.finished.connect(func():
			Data.slot1 = 1 
			queue_free() # Não esqueça de remover o item do mundo!
		)
