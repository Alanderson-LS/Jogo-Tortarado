extends Label

func _ready() -> void:
	TaskManager.task_changed.connect(_on_task_changed)

func _on_task_changed(task: String) -> void:
	text = task
