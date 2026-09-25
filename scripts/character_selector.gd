extends Control

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("change_character"):
		if not visible:
			appear()
		else:
			hide()

func appear() -> void:
	# kill all children of the vbox
	# twice for good measure
	# then spawn new buttons
	for child in $VBoxContainer.get_children():
		# kill the child
		child.queue_free()
	
	if len(GameState.active_characters) <= 1:
		return
	
	for character in GameState.active_characters:
		var button = CharacterButton.new()
		button.character_name = character
		button.character_id = character
		button.character_selected.connect(_on_button_pressed)
		$VBoxContainer.add_child(button)
	
	show()

func _on_button_pressed(id: String):
	# the twice killing
	for child in $VBoxContainer.get_children():
		# kill all the children
		child.queue_free()
	
	GameState.change_active_player(id)
	hide()
