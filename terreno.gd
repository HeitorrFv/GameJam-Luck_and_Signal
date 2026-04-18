extends TileMapLayer

@export var width: int = 50
@export var height: int = 50
@export var noise_seed: int = 0

var noise: FastNoiseLite

func _ready():
	generate_simple_random()

func generate_simple_random():
	for x in range(width):
		for y in range(height):
			var tile_coords: Vector2i
			
			# gera um número entre 0.0 e 1.0
			if randf() < 0.10: 
				tile_coords = Vector2i(0, 0) # 1 em 3 chances (Tile B)
			else:
				tile_coords = Vector2i(1, 0) # O restante (Tile A)
				
			set_cell(Vector2i(x, y), 0, tile_coords)
