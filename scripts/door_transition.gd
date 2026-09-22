class_name DoorTransition
extends Area2D

@export_file("*.tscn") var target_scene
@export var spawn_point: String

func _ready() -> void:
	$Sprite2D.set_instance_shader_parameter("outline_enabled", false)

func interact():
	GameState.change_scene(target_scene, spawn_point)

func highlight(state: bool) -> void:
	$Sprite2D.set_instance_shader_parameter("outline_enabled", state)
