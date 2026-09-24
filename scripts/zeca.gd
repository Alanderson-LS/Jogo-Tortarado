extends Area2D

var rock: ItemData = load("res://assets/items/rock.tres")

func interact():
	if not GameState.inventories[GameState.active_player].has_item(rock):
		GameState.inventories[GameState.active_player].add_item(rock)
		UiManager.set_current_task("Espante os pássaros")
