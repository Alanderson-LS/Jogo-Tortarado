extends Node

signal task_changed(task: String)

var current_task: String = ""
var duration: float = 0.0

func set_current_task(task: String) -> void:
	current_task = task
	task_changed.emit(current_task)
