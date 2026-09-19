extends Node2D
const BIRD = preload("res://scenes/bird.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_bird(0, 200)
	create_bird(0, 100)
	create_bird(1150, 200)
	create_bird(1150, 100)

func create_bird(x, y):
	var new_bird = BIRD.instantiate()
	
	new_bird.inicio = Vector2(x, y)
	
	add_child(new_bird)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
