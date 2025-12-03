class_name LevelLoop
extends Node2D

@onready var player: Node = $player
@onready var camera: Camera2D = $Camera2D

var tp_distance: float = 0.0
var tp_to_left_position: float = -1200.0
var tp_to_right_position: float = 4140.0

func _ready() -> void:
	pass  # Replace with function body.


func tp_player_to_left_end() -> void:

	tp_distance = player.position.x - tp_to_left_position
	player.position.x = tp_to_left_position  # Example position for left end
	camera.position.x -= tp_distance

	print("Teleporting player to left end")
	pass  # Replace with function body.

func tp_player_to_right_end() -> void:

	tp_distance = player.position.x - tp_to_right_position
	player.position.x = tp_to_right_position  # Example position for right end
	camera.position.x -= tp_distance

	print("Teleporting player to right end")
	pass  # Replace with function body.
