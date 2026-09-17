extends Node

const PLAYER_SCENE = preload("res://scenes/player.tscn")

var active_player: int = 0
var can_change_player: bool = true

# indexed by player id
var inventories: Array[Inventory] = [Inventory.new(), Inventory.new()]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	load_scene("res://scenes/outside.tscn", "Outside")

func change_active_player():
	active_player = 1 - active_player

func update_active_player():
	for player in get_tree().get_nodes_in_group("player"):
		player.set_controlled(
			player.character_id == active_player
		)

func load_scene(scene: String, spawn_name: String):
	get_tree().change_scene_to_file(scene)
	
	await get_tree().scene_changed
	
	var current_scene = get_tree().current_scene
	
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

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("up"):
		GameState.change_active_player()
		GameState.update_active_player()
