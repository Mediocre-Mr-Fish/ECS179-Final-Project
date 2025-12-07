class_name LevelLoop
extends Node2D

@onready var player: Node = $player
@onready var camera: Camera2D = $Camera2D
@onready var tp_to_left_mark: Node2D = $LeftTPTrigger/TPToLeftMark
@onready var tp_to_right_mark: Node2D = $RightTPTrigger/TPToRightMark

var tp_distance: float = 0.0
var tp_to_left_position: float = -1200.0
var tp_to_right_position: float = 4140.0

func _ready() -> void:
	tp_to_left_position = tp_to_left_mark.global_position.x
	tp_to_right_position = tp_to_right_mark.global_position.x


func tp_player_to_left_end() -> void:

	tp_distance = player.position.x - tp_to_left_position
	player.position.x = tp_to_left_position 
	camera.position.x -= tp_distance
	# whatever else needs to be done when teleporting to left end
	print("Teleporting player to left end")

func tp_player_to_right_end() -> void:

	tp_distance = player.position.x - tp_to_right_position
	player.position.x = tp_to_right_position 
	camera.position.x -= tp_distance

	print("Teleporting player to right end")
