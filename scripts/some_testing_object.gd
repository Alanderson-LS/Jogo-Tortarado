extends Area2D

var key: ItemData = load("res://assets/items/testing_item.tres")

func interact():
	if not GameState.inventories[GameState.active_player].has_item(key):
		print("adding key to inventory ", GameState.active_player)
		GameState.inventories[GameState.active_player].add_item(key)
		
		print("setting selected object cause i can't do ui this time")
		GameState.inventories[GameState.active_player].current_item = 0
		print(GameState.inventories[GameState.active_player].inventory)
		
		TaskManager.set_current_task("Use the not key")
