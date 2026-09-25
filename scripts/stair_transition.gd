extends Area2D

@export var path: Path2D
@export var duration: float = 0.5

var player: CharacterBody2D
var start_position: Vector2
var transitioning = false
var start_curve_position: Vector2

func start_transition(p: CharacterBody2D):
	if transitioning:
		return
	
	player = p
	start_position = player.global_position
	transitioning = true
	
	start_curve_position = path.curve.sample_baked(0.0)
	
	player.set_physics_process(false)
	
	var tween := create_tween()
	tween.tween_method(
		move_player_along_path,
		0.0,
		1.0,
		duration
	)
	
	await tween.finished
	
	transitioning = false
	player.set_physics_process(true)
	player = null

func move_player_along_path(t: float):
	var point: Vector2 = path.curve.sample_baked(
		path.curve.get_baked_length() * t
	)
	
	var offset: Vector2 = point - start_curve_position
	
	player.global_position = start_position + offset

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		start_transition(body)
