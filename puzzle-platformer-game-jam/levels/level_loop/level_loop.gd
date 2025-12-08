class_name LevelLoop
extends Node2D

@export var guide: Node2D = null
@export var node_list: Array[Node2D] = []

@onready var player: Node = $player
@onready var camera: Camera2D = $Camera2D
@onready var tp_to_left_mark: Node2D = $LeftTPTrigger/TPToLeftMark
@onready var tp_to_right_mark: Node2D = $RightTPTrigger/TPToRightMark

@onready var far_past_room: Node2D = $FarPast
@onready var past_room: Node2D = $Past
@onready var present_room: Node2D = $Present

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
	current_room_age = RoomAge.FARPAST
	tp_to_left_position = tp_to_left_mark.global_position.x
	tp_to_right_position = tp_to_right_mark.global_position.x


func _physics_process(delta: float) -> void:
	_handle_torch_mechanics()


# All torch-related mechanics are handled here
func _handle_torch_mechanics() -> void:
	#Show "too dark" warning in PRESENT room when torch is off
	_handle_darkness_warning()
	
	# Handle torch lighting logic
	_handle_torch_lighting()


func _handle_darkness_warning() -> void:
	if current_room_age == RoomAge.PRESENT:
		if not player.is_player_torch_light_on():
			guide.this_is_too_dark.visible = true
			# Only set the flag once when warning is first shown
			if not player.is_saw_darkness_warning:
				player.is_saw_darkness_warning = true
		else:
			guide.this_is_too_dark.visible = false
	else:
		guide.this_is_too_dark.visible = false


func _handle_torch_lighting() -> void:
	var is_near_light_source = false
	var torch_interact_consumed = false
	
	# Check if player is near any light source in the node_list
	for node in node_list:
		if node and player.global_position.distance_to(node.global_position) < 200.0:
			is_near_light_source = true
			
			# Show prompt to light torch if player has torch but it's not lit
			if player.has_torch() and player.is_torch_out() and not player.is_player_torch_light_on():
				guide.press_e_to_light_torch.visible = true
				
				# Light the torch when E is pressed
				if Input.is_action_just_pressed("torch_interact"):
					player.light_torch()
					guide.press_e_to_light_torch.visible = false
					torch_interact_consumed = true
			else:
				guide.press_e_to_light_torch.visible = false
			break
	
	# Hide prompt when not near any light source
	if not is_near_light_source:
		guide.press_e_to_light_torch.visible = false
	
	# Update player state
	player.set_near_light_source(is_near_light_source)
	player.set_torch_interact_consumed(torch_interact_consumed)
			

func tp_player_to_left_end() -> void:
	room_age_change(false) 
	switch_room_age()

	tp_distance = player.position.x - tp_to_left_position
	player.position.x = tp_to_left_position 
	camera.position.x -= tp_distance
	# whatever else needs to be done when teleporting to left end
	print("Teleporting player to left end")

func tp_player_to_right_end() -> void:
	room_age_change(true) 
	switch_room_age()

	tp_distance = player.position.x - tp_to_right_position
	player.position.x = tp_to_right_position 
	camera.position.x -= tp_distance

	print("Teleporting player to right end")

func room_age_change(_is_moving_left: bool) -> void:
	# far past <--> past <--> present <--> past <--> far past (loop)
	if _is_moving_left:
		current_room_age_index -= 1
		print("Current Room Age Index: ", current_room_age_index)
		if current_room_age_index < 0:
			current_room_age_index = 3
	else:
		current_room_age_index += 1
		print("Current Room Age Index: ", current_room_age_index)
		if current_room_age_index > 3:
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

func switch_room_age() -> void:
	match current_room_age:
		RoomAge.FARPAST:
			far_past_room.visible = true
			past_room.visible = false
			present_room.visible = false
			print("Switched to FAR PAST")
		RoomAge.PAST:
			far_past_room.visible = false
			past_room.visible = true
			present_room.visible = false
			print("Switched to PAST")
		RoomAge.PRESENT:
			far_past_room.visible = false
			past_room.visible = false
			present_room.visible = true
			print("Switched to PRESENT")
	pass
