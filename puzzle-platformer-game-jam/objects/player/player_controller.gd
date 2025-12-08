class_name PlayerController
extends CharacterBody2D

signal filter_switch(color)

enum Facing {
	LEFT,
	RIGHT,
}
enum FacingY{
	UP,
	NEUTRAL,
	DOWN,
}
enum Items{
	BEHOLDER,
	LASSO,
	TORCH,
	RED,
	BLUE,
	GREEN,
}

const SPEED = 600.0
const JUMP_VELOCITY = -950.0
const SLOW_FALL_RATIO = 0.4
const GRAVITY_CORRECTION_RATIO = 2.5
const IN_THE_AIR_ACCELERATION_RATIO = 0.05

@export var inventory: Array[Items] = []
@export var menu_route: String
@export var pushForce: float = 100.0
@export var forwards_box_extender_ratio: float = 0.1

var facing:Facing = Facing.RIGHT
var facing_y:FacingY = FacingY.NEUTRAL

# 'Has' should be depreciated and replaced with the inventory system, but whatever
# Imma leave this in cause it might break y'alls code if I change it - Wen
var hasBeholder = false
var hasLasso = false
var hasTorch = false
var beholder:Array = []
var currentColor = null

# Player commands
var input_enabled: bool = true
var input_locked: bool = false
var cmd_list: Array = []

# Torch related variables
var _is_having_torch: bool = false
var _is_having_torch_out: bool = false
var _is_torch_light_on: bool = false
var torch_light_texture: Texture2D = preload("res://assets/Adventure_Platformer/Player/Player_Character_Sheet_V3.png")
var torch_light_off_texture: Texture2D = preload("res://assets/Adventure_Platformer/Player/Player_Character_Sheet_V3_Torch_No_Fire.png")
@onready var torch_light: Node2D = $PlayerSprite2D/TorchLight


@onready var sprite: PlayerSprite = $PlayerSprite2D
@onready var PlayerSFXPlayer: AudioStreamPlayer2D = get_node("/root/AutoloadAudioPlayer/PlayerSFXPlayer")
@onready var animation_tree:AnimationTree = $AnimationTree
# A second shape that extends the touch hitbox in the direction of movement
# to compensate for high movenet speed
@onready var forwards_box_extender: CollisionShape2D = $TouchHitBox/ForwardsBoxExtender
@onready var fade: ColorRect = $"../Fade"

func _ready() -> void:
	fade.modulate.a = 1.0
	
	facing = Facing.RIGHT
	facing_y = FacingY.NEUTRAL
	sprite.change_facing(self)
	animation_tree.active = true
	sprite.texture = torch_light_off_texture
	
	_fade_in(1.5)
	for i in inventory:
		match i:
			Items.BEHOLDER:
				hasBeholder = true
			Items.TORCH:
				hasTorch = true
				_is_having_torch = true
			Items.LASSO:
				hasLasso = true
			Items.RED:
				beholder.append(colors.FilterColors.RED)
				currentColor = colors.FilterColors.RED
			Items.GREEN:
				beholder.append(colors.FilterColors.GREEN)
				currentColor = colors.FilterColors.GREEN
			Items.BLUE:
				beholder.append(colors.FilterColors.BLUE)
				currentColor = colors.FilterColors.BLUE
	
func _physics_process(delta: float) -> void:
	# Locks movement on death
	_process_commands()
	if not input_enabled:
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * GRAVITY_CORRECTION_RATIO

	# Handle jump.
	# If character is on floor and jump is pressed, initiate jump.
	# If character is in air and jump is pressed, apply slow fall.
	# Kinda like the mechnism in google dinosaur game.
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		else:
			velocity -= get_gravity() * delta * SLOW_FALL_RATIO * IN_THE_AIR_ACCELERATION_RATIO


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction:Vector2 = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))

	# Handle character walking.
	# Walk normally on ground.
	# Apply small amount of acceleration in the air.
	# But only in the opposite direction.
	if is_on_floor():
		if direction:
			velocity.x = direction.x * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED * 0.1)
	else:
		if sign(velocity.x) != sign(direction.x):
			velocity.x += direction.x * SPEED * 0.1 
	
	# move the second touchbox in the direction of movement	
	forwards_box_extender.position = velocity * forwards_box_extender_ratio
	
	if not Input.is_action_pressed("look_in_direction"):
		if direction.x > 0:
			if facing != Facing.RIGHT:
				facing = Facing.RIGHT
				sprite.change_facing(self)
			
		elif direction.x < 0:
			if facing != Facing.LEFT:
				facing = Facing.LEFT
				sprite.change_facing(self)
		
		if is_zero_approx(direction.y):
			if facing_y != FacingY.NEUTRAL:
				facing_y = FacingY.NEUTRAL
		elif direction.y < 0:
			if facing_y != FacingY.UP:
				facing_y = FacingY.UP
		elif direction.y > 0:
			if facing_y != FacingY.DOWN:
				facing_y = FacingY.DOWN
	
	if Input.is_action_just_pressed("torch_interact"):
		_is_having_torch_out = not _is_having_torch_out
		

	if Input.is_action_just_pressed("filter_switch"):
		if not hasBeholder:
			return
		#if theres no current color, pick the first color gem player picked up
		if currentColor == null:
			return
		#get index of current color in the beholder
		var index = beholder.find(currentColor)
		#set the color to the next one inside the beholder
		currentColor = beholder[(index+1)%beholder.size()]
		filter_switch.emit(currentColor)

	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("menu"):
		get_tree().change_scene_to_file(menu_route)
	
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		#print("I collided with ", collision.get_collider().name)
		if collision.get_collider() is RigidBody2D:
			collision.get_collider().apply_force(collision.get_normal() * -pushForce)
			
	_manage_animation_tree_state()

func command_callback(cmd_name:String) -> void:
	if "burst" == cmd_name:
		pass
		#_play($Audio/attack)
		
	if "attack" == cmd_name:
		pass
		#_play($Audio/attack)
		
	if "jump" == cmd_name:
		pass
		#_play($Audio/jump)
		
	if "engage" == cmd_name:
		pass
		#_play($Audio/engage)
		
	if "undeath" == cmd_name:
		pass
		#_play($Audio/undeath)

#Logic to support the state machine in the AnimationTree
func _manage_animation_tree_state() -> void:
	if !is_zero_approx(velocity.x):
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/run"] = true
	else:	
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/run"] = false
	
	if is_on_floor():
		animation_tree["parameters/conditions/jumping"] = false
		animation_tree["parameters/conditions/on_floor"] = true
	else:
		animation_tree["parameters/conditions/on_floor"] = false
		animation_tree["parameters/conditions/jumping"] = true
	
	if _is_having_torch:
		if _is_having_torch_out == true:
			animation_tree["parameters/conditions/torch"] = true
			animation_tree["parameters/conditions/untorch"] = false
			if _is_torch_light_on:
				torch_light.visible = true
				sprite.texture = torch_light_texture
			else:
				torch_light.visible = false
				sprite.texture = torch_light_off_texture
				
		else :
			animation_tree["parameters/conditions/untorch"] = true
			animation_tree["parameters/conditions/torch"] = false
			torch_light.visible = false
		
	#if take_damage:
		##animation_tree["parameters/conditions/idle"] = false
		##animation_tree["parameters/conditions/run"] = false
		##animation_tree["parameters/conditions/untorch"] = false
		##animation_tree["parameters/conditions/torch"] = false
		#animation_tree["parameters/conditions/death"] = true

		
# sound effect functions

func playback_walk_sfx() -> void:
	if is_on_floor():
		PlayerSFXPlayer.play_walk_sfx(global_position)
	

func player_having_torch(having: bool) -> void:
	_is_having_torch = having
	
func take_damage(if_damaged: bool) -> void:
	#var knockback_h = 500.0
	#var knockback_v = -500.0
	#var direction = -1 if facing == Facing.RIGHT else 1
	#var knockback_velocity = Vector2(direction * knockback_h, knockback_v) 
	#
	#cmd_list.push_back(DurativeKnockbackCommand.new(knockback_velocity))
	cmd_list.push_back(DurativeDeathCommand.new())
	cmd_list.push_back(FadeOutCommand.new(0.5, 1.0))
	
func spring_jump():
	velocity.y = -200 + JUMP_VELOCITY
	
	
func _process_commands():
	#if not input_enabled or input_locked:
		#return
		
	if cmd_list.size() == 0:
		return
	
	var status = cmd_list[0].execute(self)
	
	match status:
		Command.Status.DONE:
			var finished_cmd = cmd_list.pop_front()
		
			if finished_cmd is FadeOutCommand:
				get_tree().reload_current_scene()
				
		Command.Status.ACTIVE:
			pass
			
		Command.Status.ERROR:
			print("command error")
			cmd_list.pop_front()
	
func _fade_in(duration: float) -> void:
	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0.0, duration)
