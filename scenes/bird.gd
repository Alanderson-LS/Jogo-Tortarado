extends Node2D

var inicio = Vector2(0, 200)
var comida = Vector2(550, 650)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	entrar()

func entrar():
	var tween = create_tween()

	position = inicio

	tween.tween_property(
		self,
		"position",
		comida,
		3.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
func sair():
	var tween = create_tween()

	tween.tween_property(
		self,
		"position",
		Vector2(1150 - inicio.x, inicio.y),
		3.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
