extends CanvasLayer

@export var target_password: Array[int] = [1, 3, 7, 2]
@export var password: Array[Label] = []
@export var control: Control
@export var button_briefcase: TextureButton
@export var sfx_click: AudioStreamPlayer
@export var sfx_unlocked_case: AudioStreamPlayer

signal mala_aberta

func _ready() -> void:
	control.visible = false

func _on_case_pressed() -> void:
	control.visible = true

func _on_arrow_pressed(scroll_index: int, increment: int) -> void:
	var label := password[scroll_index]
	var value := int(label.text)
	value = wrapi(value + increment, 0, 10)
	label.text = str(value)
	if sfx_click:
		sfx_click.play()
	_verify_password()

func _verify_password() -> void:
	for i in target_password.size():
		if int(password[i].text) != target_password[i]:
			return
	_open_briefcase()

func _open_briefcase() -> void:
	if sfx_unlocked_case:
		sfx_unlocked_case.play()
	print("mala_aberta")

	#emit_signal("mala_aberta") isso aq é o sinal de fim de jogo.
	# aqui entra depois a animação de abertura + revelar a faca de marfim
