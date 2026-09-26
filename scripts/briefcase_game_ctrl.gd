extends CanvasLayer

@export var target_password: Array[int] = [1, 3, 7, 2]
@export var password: Array[Label] = []
@export var control_panel: Panel
@export var button_briefcase: TextureButton
@export var sfx_click: AudioStreamPlayer2D
@export var sfx_unlocked_case: AudioStreamPlayer2D

var unlocked:bool = false

signal mala_aberta

func _ready() -> void:
	control_panel.visible = false

func _on_case_pressed() -> void:
	print("case panel UI shown, code:")
	control_panel.visible = true

func _on_arrow_pressed(scroll_index: int, increment: int) -> void:
	if !unlocked:
		var label := password[scroll_index]
		var value := int(label.text)
		value = wrapi(value + increment, 0, 10)
		label.text = str(value)
		if sfx_click:
			sfx_click.play()
		_verify_password()
	else:
		return

func _verify_password() -> void:
	for i in target_password.size():
		if int(password[i].text) != target_password[i]:
			return
	_open_briefcase()

func _open_briefcase() -> void:
	unlocked = true
	if sfx_unlocked_case:
		sfx_unlocked_case.play()
	print("case opened")
	await get_tree().create_timer(2.0).timeout
	control_panel.visible = false
	#emit_signal("mala_aberta") isso aq é o sinal de fim de jogo.
	# aqui entra depois a animação de abertura + revelar a faca de marfim
