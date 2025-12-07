class_name PlayerSprite
extends Node2D

@export var unflipped_position:Vector2
@export var flipped_position:Vector2
@onready var torch_light: Node2D = $TorchLight
var temp_torch_light_position_x: float = 0.0

func _ready() -> void:
	temp_torch_light_position_x = torch_light.position.x

func change_facing(player:PlayerController) -> void:
	if PlayerController.Facing.RIGHT == player.facing:
		position = flipped_position
		self.flip_h = false
		torch_light.position.x = temp_torch_light_position_x
		#print("left")
	elif PlayerController.Facing.LEFT == player.facing:
		position = unflipped_position
		self.flip_h = true
		torch_light.position.x = -temp_torch_light_position_x
		#print("right")
