class_name Guide
extends Node2D

@onready var player: Node2D = get_parent()
@export var crown: Node2D = null

@onready var treaure_is_ahead: TabBar = $TreasureIsAhead
@onready var press_e_to_pick_up: TabBar = $PressEToPickUp
@onready var press_e_to_pick_up_torch: TabBar = $PressEToPickUpTorch
@onready var time_to_leave: TabBar = $TimeToLeave
@onready var this_is_too_dark: TabBar = $ThisIsTooDark
@onready var press_e_to_light_torch: TabBar = $PressEToLightTorch

var _is_crown_picked_up: bool = false
var distance_to_treasure: float = 0.0

func _ready() -> void:
	treaure_is_ahead.visible = false
	press_e_to_pick_up.visible = false
	press_e_to_pick_up_torch.visible = false
	time_to_leave.visible = false
	press_e_to_light_torch.visible = false

	show_num_seconds(treaure_is_ahead,3)

func _physics_process(delta: float) -> void:
	
	if _is_crown_picked_up == false:
		distance_to_treasure = player.position.distance_to(crown.position)
		if distance_to_treasure < 200.0:
			press_e_to_pick_up.visible = true
			if Input.is_action_just_pressed("torch_interact"):
				_is_crown_picked_up = true
				crown.queue_free()
				show_num_seconds(time_to_leave,3)
		else:
			press_e_to_pick_up.visible = false
	else:
		press_e_to_pick_up.visible = false

	
func show_num_seconds(node: TabBar, seconds: int) -> void:
	node.visible = true
	await get_tree().create_timer(seconds).timeout
	node.visible = false
