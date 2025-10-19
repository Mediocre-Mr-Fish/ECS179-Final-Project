class_name PlayerSprite
extends Node2D

@export var unflipped_position:Vector2
@export var flipped_position:Vector2


func change_facing(player:PlayerController) -> void:
	if PlayerController.Facing.LEFT == player.facing:
		position = flipped_position
		self.flip_h = false
		#print("left")
	elif PlayerController.Facing.RIGHT == player.facing:
		position = unflipped_position
		self.flip_h = true
		#print("right")
