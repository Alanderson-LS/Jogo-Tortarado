extends CharacterBody2D

const SPEED = 300.0

@export var ground_raycast: RayCast2D
@export var interaction_area: Area2D

var nearby_interactable: Node = null

@export var character_id: int
@export var can_move: bool = true

func _ready() -> void:
	Dialogic.timeline_started.connect(_on_dialogue_started)
	Dialogic.timeline_ended.connect(_on_dialogue_ended)
	TaskManager.set_current_task("teste real de task aaaaaa")

func set_controlled(controlled: bool):
	if controlled:
		$Camera2D.enabled = true
	else:
		$Camera2D.enabled = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if character_id == GameState.active_player:
		if can_move:
			var direction := Input.get_axis("left", "right")
			velocity.x = direction * SPEED
	else:
		velocity.x = 0
	
	move_and_slide()

func _process(delta: float) -> void:
	$Camera2D.enabled = character_id == GameState.active_player

func _input(event: InputEvent) -> void:
	if character_id == GameState.active_player:
		if event.is_action_pressed("interact") and nearby_interactable:
			# try to use item
			if GameState.inventories[character_id].current_item != -1 and\
			   nearby_interactable.has_method("use_item"):
				nearby_interactable.use_item(
					GameState.inventories[character_id]
					.inventory[GameState.inventories[character_id].current_item]
				)
				GameState.inventories[character_id].current_item = -1
			# normal interact
			elif GameState.inventories[character_id].current_item == -1 and\
			   nearby_interactable.has_method("interact"):
				nearby_interactable.interact()
			

func _on_interaction_area_area_entered(area: Area2D) -> void:
	if area.has_method("interact") or area.has_method("use_item"):
		nearby_interactable = area

func _on_interaction_area_area_exited(area: Area2D) -> void:
	if area == nearby_interactable:
		nearby_interactable = null

func _on_dialogue_started() -> void:
	can_move = false

func _on_dialogue_ended() -> void:
	can_move = true
