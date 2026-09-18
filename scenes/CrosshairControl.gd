extends Control

@export var projetil_texture: Texture2D = preload("res://rock.png")
@export var velocidade := 800.0
@export var drop := 100.0
@export var cooldown := 0.5
@export var tamanho_pedra := 0.05
@export var velocidade_giro := 2.0
@export var tempo_para_diminuir := 0.5
@export var velocidade_diminuicao := 0.5

var cooldown_restante := 0.0

func mover_projetil(projetil, destino):
	var inicio = projetil.position
	var distancia = inicio.distance_to(destino)
	var tempo = distancia / velocidade
	var meio = (inicio + destino) / 2

	# Quanto a pedra vai "cair"
	
	meio.y += drop

	var tween = create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)

	tween.tween_property(
		projetil,
		"position",
		destino,
		tempo
	)
	tween.tween_property(
		projetil,
		"position:y",
		destino.y + drop,
		0.5
	)

func girar_projetil(projetil):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)

	tween.tween_property(
		projetil,
		"rotation",
		projetil.rotation + TAU * 100,
		100.0 / velocidade_giro
	)

func diminuir_projetil(projetil):
	await get_tree().create_timer(tempo_para_diminuir).timeout

	if not is_instance_valid(projetil):
		return

	var tween = create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)

	tween.tween_property(
		projetil,
		"scale",
		Vector2(0.0, 0.0),
		velocidade_diminuicao
	)

	tween.tween_callback(projetil.queue_free)

func atirar():
	print("ATIROU!")
	var projetil = TextureRect.new()

	projetil.texture = projetil_texture
	projetil.size = Vector2(32, 32)
	projetil.scale = Vector2(0.05, 0.05)
	projetil.pivot_offset = projetil.size / 2
	projetil.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	projetil.mouse_filter = Control.MOUSE_FILTER_IGNORE

	add_child(projetil)
	# Nasce no centro inferior da tela
	projetil.position = Vector2(
		size.x / 2 - projetil.size.x / 2,
		size.y - projetil.size.y / 2
	)
	
	# Guarda onde o mouse estava quando clicou
	var destino = get_viewport().get_mouse_position() - projetil.size / 2
	mover_projetil(projetil, destino)
	girar_projetil(projetil)
	diminuir_projetil(projetil)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.

@onready var mira = $TextureRect

func _process(_delta):
	mira.position = get_viewport().get_mouse_position() - mira.size / 2
		
	if cooldown_restante > 0:
		cooldown_restante -= _delta
		
	if Input.is_action_just_pressed("click") and cooldown_restante <= 0:
		atirar()
		cooldown_restante = cooldown
	
