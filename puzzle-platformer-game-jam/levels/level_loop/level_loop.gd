class_name LevelLoop
extends Node2D

@export var guide: Node2D = null
@export var node_list: Array[Node2D] = []
@export var player_crown: Node2D = null
@export var the_painting: Node2D = null
@export var exit: Node2D = null

var player_crown_picked_up: bool = false

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

var dist_to_the_painting: float = 0.0

func _ready() -> void:
	current_room_age = RoomAge.FARPAST
	tp_to_left_position = tp_to_left_mark.global_position.x
	tp_to_right_position = tp_to_right_mark.global_position.x
	
	# Initialize player_crown as hidden
	if player_crown:
		player_crown.visible = false

var _is_noitced_something_wrong_with_painting : bool = false
var _is_noitced_the_painting_looking_at_player : bool = false
var _is_noticed_need_to_do_something : bool = false
var _is_ready_to_set_painting_on_fire : bool = false
var _painting_warning_cooldown: float = 0.0
var _is_game_end : bool = false

func _physics_process(delta: float) -> void:
	_handle_torch_mechanics()
	_handle_crown_visibility()
	
	# Update cooldown timer
	if _painting_warning_cooldown > 0.0:
		_painting_warning_cooldown -= delta

	if current_room_age == RoomAge.PRESENT and not _is_game_end:
		dist_to_the_painting = player.position.distance_to(the_painting.position)
		# print("Distance to painting: ", dist_to_the_painting)
		if dist_to_the_painting < 600.0 and not _is_noitced_something_wrong_with_painting and _painting_warning_cooldown <= 0.0:
			print("Noticed something wrong with the painting")
			print(dist_to_the_painting)
			_is_noitced_something_wrong_with_painting = true
			_painting_warning_cooldown = 3.0  # Set 3 second cooldown
			guide.show_num_seconds(guide.something_is_wrong_with_the_painting,3)

		elif dist_to_the_painting < 600.0 and not _is_noitced_the_painting_looking_at_player and _painting_warning_cooldown <= 0.0:
			print("Noticed the painting is looking at player")
			print(dist_to_the_painting)
			_is_noitced_the_painting_looking_at_player = true
			_painting_warning_cooldown = 3.0  # Set 3 second cooldown
			guide.show_num_seconds(guide.the_painting_is_looking_at_player,3)

		elif dist_to_the_painting < 600.0 and not _is_noticed_need_to_do_something and _painting_warning_cooldown <= 0.0:
			print("Noticed need to do something about the painting")
			print(dist_to_the_painting)
			_is_noticed_need_to_do_something = true
			_painting_warning_cooldown = 3.0  # Set 3 second cooldown
			guide.show_num_seconds(guide.i_need_to_do_something,3)
			_is_ready_to_set_painting_on_fire = true

	if _is_ready_to_set_painting_on_fire and _painting_warning_cooldown <= 0.0 and dist_to_the_painting < 600.0:
			guide.show_prompt(guide.press_e_to_set_on_fire)
			if Input.is_action_just_pressed("torch_interact"):
				print("Setting the painting on fire!")
				_is_ready_to_set_painting_on_fire = false
				the_painting.set_on_fire()
				player.playback_thunder_sfx() 
				guide.hide_prompt(guide.press_e_to_set_on_fire)
				_painting_warning_cooldown = 5.0  # Set 3 second cooldown
				_is_game_end = true
	elif _is_game_end and _painting_warning_cooldown <= 0.0:
			guide.hide_prompt(guide.press_e_to_set_on_fire)
			the_painting.visible = false
			exit.position.y = 427.0
			

		
			
			# You can add additional logic here for when the player reaches the painting


# All torch-related mechanics are handled here
func _handle_torch_mechanics() -> void:
	#Show "too dark" warning in PRESENT room when torch is off
	_handle_darkness_warning()
	
	# Handle torch lighting logic
	_handle_torch_lighting()


func _handle_darkness_warning() -> void:
	if current_room_age == RoomAge.PRESENT:
		if not player.is_player_torch_light_on():
			guide.show_prompt(guide.this_is_too_dark)
			# Only set the flag once when warning is first shown
			if not player.is_saw_darkness_warning:
				player.is_saw_darkness_warning = true
		else:
			guide.hide_prompt(guide.this_is_too_dark)
	else:
		guide.hide_prompt(guide.this_is_too_dark)


func _handle_torch_lighting() -> void:
	var is_near_light_source = false
	var torch_interact_consumed = false
	
	# Check if player is near any light source in the node_list
	for node in node_list:
		if node and player.global_position.distance_to(node.global_position) < 200.0:
			is_near_light_source = true
			
			# Show prompt to light torch if player has torch but it's not lit
			if player.has_torch() and player.is_torch_out() and not player.is_player_torch_light_on():
				guide.show_prompt(guide.press_e_to_light_torch)
				
				# Light the torch when E is pressed
				if Input.is_action_just_pressed("torch_interact"):
					player.light_torch()
					guide.hide_prompt(guide.press_e_to_light_torch)
					torch_interact_consumed = true
			else:
				guide.hide_prompt(guide.press_e_to_light_torch)
			break
	
	# Hide prompt when not near any light source
	if not is_near_light_source:
		guide.hide_prompt(guide.press_e_to_light_torch)
	
	# Update player state
	player.set_near_light_source(is_near_light_source)
	player.set_torch_interact_consumed(torch_interact_consumed)


var real_room_age: RoomAge = RoomAge.PAST
func _handle_crown_visibility() -> void:
	
	if player_crown and player_crown_picked_up:
		if Input.is_action_just_pressed("filter_activate"):
			player_crown.visible = not player_crown.visible

			if player_crown.visible:
				current_room_age = real_room_age
				switch_room_age()
			else:
				real_room_age = current_room_age
				current_room_age = RoomAge.FARPAST
				
				switch_room_age()
				
			

func tp_player_to_left_end() -> void:
	room_age_change_handler()

	tp_distance = player.position.x - tp_to_left_position
	player.position.x = tp_to_left_position 
	camera.position.x -= tp_distance
	# whatever else needs to be done when teleporting to left end
	print("Teleporting player to left end")

func tp_player_to_right_end() -> void:
	room_age_change_handler()

	tp_distance = player.position.x - tp_to_right_position
	player.position.x = tp_to_right_position 
	camera.position.x -= tp_distance

	print("Teleporting player to right end")

func room_age_change_handler() -> void:
	room_age_change()
	switch_room_age()

func room_age_change() -> void:
	# far past <--> past <--> present <--> past <--> far past (loop)
	if player_crown.visible:
		# if crown is visible, then show far past and past
		print("Crown is visible, toggling between PAST and PRESENT")
		if current_room_age == RoomAge.PAST:
			current_room_age = RoomAge.PRESENT
		elif current_room_age == RoomAge.PRESENT:
			current_room_age = RoomAge.PAST
		return
	else:
		# crown not visible
		print("Crown is not visible, cycling through all room ages")


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
