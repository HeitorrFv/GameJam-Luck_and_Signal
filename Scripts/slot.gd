extends Button
@export var ID = 0
@export var item1: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ID == 1:
		Data.item1 = self
	elif ID == 2:
		Data.item2 = self
	elif ID == 3:
		Data.item3 = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Data.slot1 == 1:
		var item = item1.instantiate()
		add_child(item)
