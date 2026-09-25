class_name CharacterButton
extends Button

signal character_selected(String)

var character_name: String:
	set(value):
		text = value
var character_id: String

func _ready():
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	character_selected.emit(character_id)
