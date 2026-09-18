extends RichTextLabel

var original_text = ""
var duration = 1.0

func _ready() -> void:
	original_text = text
	TaskManager.task_changed.connect(_on_task_changed)

func _on_task_changed(task: String) -> void:
	await strikethrough()
	text = task
	original_text = task
	modulate.a = 1.0

func strikethrough() -> Signal:
	var tween := create_tween()
	tween.tween_method(_update_strikethrough, 0.0, 1.0, duration)
	tween.tween_method(_fade_out, 1.0, 0.0, duration).set_delay(duration)
	return tween.finished

func _update_strikethrough(progress: float):
	var count := int(original_text.length() * progress)

	var struck := original_text.substr(0, count)
	var remaining := original_text.substr(count)

	text = "[s]" + struck + "[/s]" + remaining

func _fade_out(progress: float):
	modulate.a = progress
