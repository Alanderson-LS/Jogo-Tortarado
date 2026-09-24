extends Node

const PLAYER_SCENE = preload("res://scenes/player.tscn")

signal active_player_changed(id: String)
signal inventory_updated

#TODO: maybe change to a string?
var active_player: String
var can_change_player: bool = true

#TODO: Maybe switch to a dictionary
# indexed by player id
var inventories: Dictionary[String, Inventory] = {"belonisia": Inventory.new(), "bibiana": Inventory.new()}

var active_characters = [
	"belonisia",
	"bibiana"
]

var main

#TODO: get id to change here later
func change_active_player(new_active_player: String):
	active_player = new_active_player
	
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
	# change to menu later
	if Input.is_action_just_pressed("up"):
		if active_player == "belonisia":
			GameState.change_active_player("bibiana")
		elif active_player == "bibiana":
			GameState.change_active_player("belonisia")

func change_scene(scene: String, spawn_name: String):
	main.load_scene(scene, spawn_name)
