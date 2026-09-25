extends Button

func _ready() -> void:
	if not DisplayServer.is_touchscreen_available():
		hide()

func _on_pressed() -> void:
	Input.action_press("interact")
	Input.action_release("interact")
