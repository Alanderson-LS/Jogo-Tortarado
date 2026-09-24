extends Node

signal clear_selected
signal task_changed(task: String)

var current_task: String = ""

var main

func _ready() -> void:
	GameState.active_player_changed.connect(update_ui)
	GameState.inventory_updated.connect(update_inventory)
	
	main = GameState.main
	
	main.minigame_started.connect(_on_minigame_started)
	main.minigame_ended.connect(_on_minigame_ended)

func set_current_task(task: String) -> void:
	current_task = task
	task_changed.emit(current_task)

func update_ui(active_player: String) -> void:
	update_inventory(GameState.active_inventory())

func clear_selected_slot():
	clear_selected.emit()

func get_ui() -> CanvasLayer:
	if main == null:
		main = GameState.main
	return main.ui

# magic shittery
func update_inventory(items: Inventory):
	var ui = get_ui()
	
	ui = ui.get_child(0)
	var slots: Array[Node] = ui.get_node("HBoxContainer/InventoryContainer/MarginContainer/HBoxContainer").get_children()
	
	for i in range(9):
		if i >= len(items.inventory):
			slots[2*i].icon = null
		else:
			slots[2*i].icon = items.inventory[i].icon

func _on_minigame_started():
	var ui: Control = get_ui().get_child(0) as Control
	
	(ui.get_child(0) as Control).hide()

func _on_minigame_ended():
	var ui: Control = get_ui().get_child(0) as Control
	
	(ui.get_child(0) as Control).show()
