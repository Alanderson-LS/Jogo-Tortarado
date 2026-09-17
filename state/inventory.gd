class_name Inventory
extends Node

var inventory: Array[ItemData] = []

func add_item(item: ItemData):
	inventory.append(item)

func has_item(item: ItemData) -> bool:
	return inventory.has(item)

func remove_item(item: ItemData):
	inventory.erase(item)
