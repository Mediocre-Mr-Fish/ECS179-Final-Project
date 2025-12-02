class_name PlayerSFXPlayer
extends AudioStreamPlayer2D

@export var player_node_path: NodePath
@export var walk_sfx: AudioStream
@export var jump_sfx: AudioStream
@export var land_sfx: AudioStream


func play_walk_sfx(pos: Vector2) -> void:
	if walk_sfx != null:
		stream = walk_sfx
		position = pos
		play()
	else:
		print("Warning: walk_sfx is not assigned.")

func play_jump_sfx() -> void:
	if jump_sfx != null:
		stream = jump_sfx
		play()
	else:
		print("Warning: jump_sfx is not assigned.")

func play_land_sfx() -> void:
	if land_sfx != null:
		stream = land_sfx
		play()
	else:
		print("Warning: land_sfx is not assigned.")
