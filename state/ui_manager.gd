extends Node

signal clear_selected
signal task_changed(task: String)

var current_task: String = ""

var main

func _ready() -> void:
	GameState.active_player_changed.connect(update_ui)
	GameState.inventory_updated.connect(update_inventory)
	main = GameState.main

func set_current_task(task: String) -> void:
	current_task = task
	task_changed.emit(current_task)

func update_ui(active_player: String) -> void:
	update_inventory(GameState.active_inventory())

func clear_selected_slot():
	clear_selected.emit()

# magic shittery
func update_inventory(items: Inventory):
	if main == null:
		main = GameState.main
	var ui = main.ui as CanvasLayer
	
	ui = ui.get_child(0)
	var slots: Array[Node] = ui.get_node("HBoxContainer/InventoryContainer/MarginContainer/HBoxContainer").get_children()
	
	for i in range(9):
		if i >= len(items.inventory):
			slots[2*i].icon = null
		else:
			slots[2*i].icon = items.inventory[i].icon
