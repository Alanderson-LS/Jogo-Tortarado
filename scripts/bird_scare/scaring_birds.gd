extends Control

@export var sfx_Crow: AudioStreamPlayer2D
@export var sfx_Throw: AudioStreamPlayer2D
@export var bird_control: Node2D

@export var projetil_texture: Texture2D
@export var velocidade := 800.0
@export var drop := 100.0
@export var cooldown := 0.5
@export var tamanho_pedra := 0.05
@export var velocidade_giro := 2.0
@export var tempo_para_diminuir := 0.5
@export var velocidade_diminuicao := 0.5

@export var mira: Control

const BIRD = preload("res://scenes/bird.tscn")

var landOptions = [100,200,300,400,500,600,700,800,900,1000]
@export var birdsHit = 0

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

func _on_pedra_hit(alvo: Area2D, projetil: Control) -> void:
	var bird = alvo.get_parent()
	if bird.has_method("sair"):
		bird_control.birds_hit += 1
		bird_control.check_win_condition(bird_control.birds_hit)
		sfx_Crow.play()
		bird.sair()
	if is_instance_valid(projetil):
		projetil.queue_free()

func atirar():
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
	sfx_Throw.play()
	
	var area = Area2D.new()
	area.collision_layer = 2  # camada da "pedra" (ajuste ao seu projeto)
	area.collision_mask = 1   # detecta objetos na camada dos pássaros
	area.add_to_group("pedra") 
	
	var shape = CollisionShape2D.new()
	var circle = CircleShape2D.new()
	circle.radius = projetil.size.x / 2  # raio aproximado da textura
	shape.shape = circle
	area.add_child(shape)

	projetil.add_child(area)
	area.area_entered.connect(_on_pedra_hit.bind(projetil))
	# se o pássaro for CharacterBody2D/StaticBody2D em vez de Area2D, use:
	# area.body_entered.connect(_on_pedra_hit.bind(projetil))
	
	# Guarda onde o mouse estava quando clicou
	var destino = get_viewport().get_mouse_position() - projetil.size / 2
	mover_projetil(projetil, destino)
	girar_projetil(projetil)
	diminuir_projetil(projetil)

func _process(_delta):
	mira.position = get_viewport().get_mouse_position() - mira.size / 2
		
	if cooldown_restante > 0:
		cooldown_restante -= _delta
		
	if Input.is_action_just_pressed("click") and cooldown_restante <= 0:
		atirar()
		cooldown_restante = cooldown

func pick_random_no_repeat():
	var chosen = landOptions.pick_random()
	landOptions.erase(chosen)
	return chosen
	
func check_win_condition(condition):
	if condition >= 4:
		print("Assustou os passaro")
	else:
		return

func create_bird(x, y, landPos):
	var new_bird = BIRD.instantiate()
	
	new_bird.inicio = Vector2(x, y)
	new_bird.comida = Vector2(
		landPos,
		600
	)
	
	add_child(new_bird)
