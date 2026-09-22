## Wraps an array of [ItemData] and stores the [member ItemData.current_item]
class_name Inventory
extends Node

var inventory: Array[ItemData] = []
var current_item: int = -1: # unselected
	set(index):
		if index >= len(inventory):
			current_item = -1
		else:
			current_item = index

func add_item(item: ItemData):
	inventory.append(item)
	UiManager.update_inventory(self)

func has_item(item: ItemData) -> bool:
	return inventory.has(item)

func remove_item(item: ItemData):
	inventory.erase(item)
	UiManager.update_inventory(self)
