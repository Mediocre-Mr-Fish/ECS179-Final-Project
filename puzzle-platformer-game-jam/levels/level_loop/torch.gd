class_name Torch
extends Node2D

@export var player: Node2D = null
@export var visible_distance: float = 100.0

@onready var torch_sprite: Sprite2D = $TorchSprite2D

var is_torch_being_taken: bool = false

func _physics_process(delta: float) -> void:
	if player == null:
		return
	
	var distance_to_player: float = position.distance_to(player.position)
	if distance_to_player < visible_distance and not is_torch_being_taken:
		torch_sprite.frame = 0
		if Input.is_action_just_pressed("torch_interact"):
			print("Torch taken by player")
			player.player_having_torch(true)
			is_torch_being_taken = true
			visible = false
	else:
		torch_sprite.frame = 1
		
	return
