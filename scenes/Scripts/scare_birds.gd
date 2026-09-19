extends Node2D
const BIRD = preload("res://scenes/bird.tscn")

var landOptions = [100,200,300,400,500,600,700,800,900,1000]
@export var birdsHit = 0

func pick_random_no_repeat():
	var chosen = landOptions.pick_random()
	landOptions.erase(chosen)
	return chosen
	
func check_win_condition(condition):
	if condition >= 4:
		print("Assustou os passaro")
	else:
		return

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_bird(0, 200, pick_random_no_repeat())
	create_bird(0, 100, pick_random_no_repeat())
	create_bird(1150, 200, pick_random_no_repeat())
	create_bird(1150, 100, pick_random_no_repeat())

func create_bird(x, y, landPos):
	var new_bird = BIRD.instantiate()
	
	new_bird.inicio = Vector2(x, y)
	new_bird.comida = Vector2(
		landPos,
		600
	)
	
	add_child(new_bird)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
