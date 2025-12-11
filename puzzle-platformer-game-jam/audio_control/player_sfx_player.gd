class_name PlayerSFXPlayer
extends AudioStreamPlayer2D

@export var player_node_path: NodePath
@export var jump_sfx: AudioStream
@export var land_sfx: AudioStream

# SFX
@export var walk_sfx_list: Array[AudioStream] = []

func _ready() -> void:
	randomize()

func play_walk_sfx(pos: Vector2) -> void:
	if walk_sfx_list != null:
		var idx := randi() % walk_sfx_list.size()
		stream = walk_sfx_list[idx]
		position = pos
		play()
	else:
		print("Warning: walk_sfx_list is not assigned or empty.")
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
