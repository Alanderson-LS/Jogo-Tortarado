extends Node2D

const PLAYER_SCENE = preload("res://scenes/player.tscn")

@onready var level_container = $Level
@onready var ui = $Ui

func _ready() -> void:
	GameState.main = self
	await get_tree().process_frame
	load_scene("res://scenes/outside.tscn", "Outside")

func new_player(global_position: Vector2, id: String):
	var player: Node2D = PLAYER_SCENE.instantiate()
	
	player.character_id = id
	player.global_position = global_position
	
	return player

func load_scene(scene: String, spawn_name: String):
	for child in level_container.get_children():
		child.queue_free()
	
	var current_scene: Node2D = load(scene).instantiate()
	
	level_container.add_child(current_scene)
	
	var spawns: Array[Node] = get_tree().get_nodes_in_group("spawn point")

	for spawn in spawns:
		if spawn is SpawnMarker and spawn.name == spawn_name:
			spawn = spawn as SpawnMarker
			for character in spawn.spawn_characters:
				current_scene.add_child(
					new_player(spawn.global_position, character)
				)
			if spawn.active_character != null:
				GameState.change_active_player(spawn.active_character)
			break
