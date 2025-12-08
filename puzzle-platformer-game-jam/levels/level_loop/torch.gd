class_name Torch
extends Node2D

@export var player: Node2D = null
@export var guide: Node2D = null
@export var visible_distance: float = 100.0
@export var level_loop: LevelLoop = null

@onready var torch_sprite: Sprite2D = $TorchSprite2D

var is_torch_being_taken: bool = false

func _physics_process(delta: float) -> void:
	if player == null:
		return
	
	var distance_to_player: float = position.distance_to(player.position)
	
	if distance_to_player < visible_distance and not is_torch_being_taken and player.is_saw_darkness_warning == true:
		torch_sprite.frame = 0
		# Show pick up prompt only in non-FARPAST rooms (or if level_loop is not set)
		var can_pick_up = true
		if level_loop != null:
			can_pick_up = level_loop.current_room_age != level_loop.RoomAge.FARPAST
		
		if can_pick_up:
			if guide:
				guide.show_prompt(guide.press_e_to_pick_up_torch)
			
			# Allow picking up torch only when prompt is shown
			if Input.is_action_just_pressed("torch_interact"):
				print("Torch taken by player")
				player.player_having_torch(true)
				is_torch_being_taken = true
				visible = false
				if guide:
					guide.hide_prompt(guide.press_e_to_pick_up_torch)
		else:
			# Hide prompt in FARPAST
			if guide:
				guide.hide_prompt(guide.press_e_to_pick_up_torch)
	else:
		torch_sprite.frame = 1
		if guide and not is_torch_being_taken:
			guide.hide_prompt(guide.press_e_to_pick_up_torch)
		
	return
