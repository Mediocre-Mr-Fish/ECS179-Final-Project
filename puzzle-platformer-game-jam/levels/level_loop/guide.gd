class_name Guide
extends Node2D

@onready var player: Node2D = get_parent()
@export var crown: Node2D = null
@export var camera: Camera2D = null

@export var level_loop: LevelLoop = null

@onready var treaure_is_ahead: TabBar = $TreasureIsAhead
@onready var press_e_to_pick_up: TabBar = $PressEToPickUp
@onready var press_e_to_pick_up_torch: TabBar = $PressEToPickUpTorch
@onready var time_to_leave: TabBar = $TimeToLeave
@onready var this_is_too_dark: TabBar = $ThisIsTooDark
@onready var press_e_to_light_torch: TabBar = $PressEToLightTorch
@onready var something_is_wrong_with_the_painting: TabBar = $SomethingIsWrongWithThePainting
@onready var the_painting_is_looking_at_player: TabBar = $ThePaintingIsLookingAtPlayer
@onready var i_need_to_do_something: TabBar = $INeedToDoSomething
@onready var press_e_to_set_on_fire: TabBar = $PressEToSetOnFire

var _is_crown_picked_up: bool = false
var distance_to_treasure: float = 0.0

func _ready() -> void:
	visible = false
	treaure_is_ahead.visible = false
	press_e_to_pick_up.visible = false
	press_e_to_pick_up_torch.visible = false
	time_to_leave.visible = false
	press_e_to_light_torch.visible = false
	this_is_too_dark.visible = false

	show_num_seconds(treaure_is_ahead,3)

func _physics_process(delta: float) -> void:
	if _is_crown_picked_up == false:
		distance_to_treasure = player.position.distance_to(crown.position)
		if distance_to_treasure < 200.0:
			show_prompt(press_e_to_pick_up)
			if Input.is_action_just_pressed("torch_interact"):
				_is_crown_picked_up = true
				print("Crown picked up! Setting level_loop flag...")
				if level_loop:
					level_loop.player_crown_picked_up = true
					print("level_loop.player_crown_picked_up set to: ", level_loop.player_crown_picked_up)
				else:
					print("ERROR: level_loop is null!")
				camera.showCrown()
				crown.queue_free()
				show_num_seconds(time_to_leave,3)
		else:
			hide_prompt(press_e_to_pick_up)
	else:
		hide_prompt(press_e_to_pick_up)
	
	# Check if any prompt is visible, if not hide the guide itself
	_update_guide_visibility()

	
func show_num_seconds(node: TabBar, seconds: int) -> void:
	show_prompt(node)
	await get_tree().create_timer(seconds).timeout
	hide_prompt(node)


# Helper function to show a prompt and make guide visible
func show_prompt(node: TabBar) -> void:
	visible = true
	node.visible = true


# Helper function to hide a prompt
func hide_prompt(node: TabBar) -> void:
	node.visible = false


# Update guide visibility based on whether any prompt is showing
func _update_guide_visibility() -> void:
	var any_visible = treaure_is_ahead.visible or press_e_to_pick_up.visible or \
					  press_e_to_pick_up_torch.visible or time_to_leave.visible or \
					  this_is_too_dark.visible or press_e_to_light_torch.visible or \
					  something_is_wrong_with_the_painting.visible or \
					  the_painting_is_looking_at_player.visible or \
					  i_need_to_do_something.visible or press_e_to_set_on_fire.visible
	visible = any_visible
