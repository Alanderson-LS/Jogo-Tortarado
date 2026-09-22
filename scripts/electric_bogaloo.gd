extends Area2D

var key: ItemData = preload("res://assets/items/testing_item.tres")

func use_item(item: ItemData):
	if item.id == key.id:
		GameState.inventories[GameState.active_player].remove_item(item)
		print("stole ya key stoopid")
