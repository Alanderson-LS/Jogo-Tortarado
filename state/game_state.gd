extends Node

const PLAYER_SCENE = preload("res://scenes/player.tscn")

signal active_player_changed(id: int)
signal inventory_updated

#TODO: maybe change to a string?
var active_player: int = 0
var can_change_player: bool = true

#TODO: Maybe switch to a dictionary
# indexed by player id
var inventories: Array[Inventory] = [Inventory.new(), Inventory.new()]

var main

#TODO: get id to change here later
func change_active_player():
	active_player = 1 - active_player
	
	for player in get_tree().get_nodes_in_group("player"):
		player.set_controlled(
			player.character_id == active_player
		)
	
	active_player_changed.emit(active_player)

func active_inventory() -> Inventory:
	return inventories[active_player]

func held_item_index() -> int:
	return active_inventory().current_item

func held_item() -> ItemData:
	return active_inventory().inventory[held_item_index()]

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("up"):
		GameState.change_active_player()

func change_scene(scene: String, spawn_name: String):
	main.load_scene(scene, spawn_name)
