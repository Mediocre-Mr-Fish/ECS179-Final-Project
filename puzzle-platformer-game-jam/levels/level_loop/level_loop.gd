class_name LevelLoop
extends Node2D

@onready var player: Node = $player
@onready var camera: Camera2D = $Camera2D
@onready var tp_to_left_mark: Node2D = $LeftTPTrigger/TPToLeftMark
@onready var tp_to_right_mark: Node2D = $RightTPTrigger/TPToRightMark

enum RoomAge {
	FARPAST,
	PAST,
	PRESENT,
}
var current_room_age_index: int = 0

var tp_distance: float = 0.0
var tp_to_left_position: float = -1200.0
var tp_to_right_position: float = 4140.0
var current_room_age: RoomAge = RoomAge.FARPAST

func _ready() -> void:
	tp_to_left_position = tp_to_left_mark.global_position.x
	tp_to_right_position = tp_to_right_mark.global_position.x


func tp_player_to_left_end() -> void:
	room_age_change() 
	switch_room_age()

	tp_distance = player.position.x - tp_to_left_position
	player.position.x = tp_to_left_position 
	camera.position.x -= tp_distance
	# whatever else needs to be done when teleporting to left end
	print("Teleporting player to left end")

func tp_player_to_right_end() -> void:
	room_age_change() 
	switch_room_age()

	tp_distance = player.position.x - tp_to_right_position
	player.position.x = tp_to_right_position 
	camera.position.x -= tp_distance

	print("Teleporting player to right end")

func room_age_change() -> void:
	# far past -> past -> present -> past -> far past
	if current_room_age_index != 4:
		current_room_age_index += 1
	else:
		current_room_age_index = 0

	match current_room_age_index:
		0:
			current_room_age = RoomAge.FARPAST
		1:
			current_room_age = RoomAge.PAST
		2:
			current_room_age = RoomAge.PRESENT
		3:
			current_room_age = RoomAge.PAST
		4:
			current_room_age = RoomAge.FARPAST

func switch_room_age() -> void:
	#
	pass
