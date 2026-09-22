extends Node2D

@export var inicio: Vector2
@export var comida: Vector2

var tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tween = create_tween()

	position = inicio

	tween.tween_property(
		self,
		"position",
		comida,
		3.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
func sair():
	if tween:
		tween.kill()
		
	tween = create_tween()

	tween.tween_property(
		$Sprite2D,
		"modulate:a",
		0.0,
		0.5
	)

	await tween.finished
	queue_free()
