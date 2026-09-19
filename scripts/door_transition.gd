class_name DoorTransition
extends Area2D

@export_file("*.tscn") var target_scene
@export var spawn_point: String

func interact():
	GameState.change_scene(target_scene, spawn_point)
