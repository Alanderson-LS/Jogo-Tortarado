extends Node2D

const PLAYER_SCENE = preload("res://scenes/player.tscn")

@onready var level_container = $Level
@onready var ui = $Ui

func _ready() -> void:
	GameState.main = self
	await get_tree().process_frame
	load_scene("res://scenes/outside.tscn", "Outside")

func load_scene(scene: String, spawn_name: String):
	for child in level_container.get_children():
		child.queue_free()
	
	var current_scene: Node2D = load(scene).instantiate()
	
	level_container.add_child(current_scene)

	
	#TODO: store this in the scene
	var player_instance_1: Node2D = PLAYER_SCENE.instantiate()
	var player_instance_2: Node2D = PLAYER_SCENE.instantiate()
	
	player_instance_1.character_id = 0
	player_instance_2.character_id = 1
	
	var spawns: Array[Node] = get_tree().get_nodes_in_group("spawn point")

	for spawn in spawns:
		if spawn is Marker2D and spawn.name == spawn_name:
			player_instance_1.global_position = (spawn as Marker2D).global_position
			player_instance_2.global_position = (spawn as Marker2D).global_position
			break

	current_scene.add_child(player_instance_1)
	current_scene.add_child(player_instance_2)
