extends Control

@export var id: int

var icon: Texture2D:
	set(value):
		$PanelContainer/Icon.texture = value

func _ready() -> void:
	UiManager.clear_selected.connect(clear_selected)

func clear_selected() -> void:
	$PanelContainer/Button.toggle_mode = false

func _on_button_toggled(toggled_on: bool) -> void:
	clear_selected()
	if toggled_on:
		GameState.active_inventory().current_item = id
		$PanelContainer/Button.toggle_mode = true
		print(GameState.held_item_index())
