extends Control

@onready var speed_slider: HSlider = %SpeedSlider

func _ready() -> void:
	speed_slider.value_changed.connect(update_character_speed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_debug"):
		visible = not visible

func update_character_speed(value) -> void:
	var players = get_tree().get_nodes_in_group("player")
	
	for player in players:
		player.speed = value
