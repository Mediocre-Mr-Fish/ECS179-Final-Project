class_name PlayerController
extends CharacterBody2D

#@onready var sprite:Sprite2D = $Sprite2D
@onready var sprite:PlayerSprite = $Sprite2D
@export var menu_route:String

enum Facing {
	LEFT,
	RIGHT,
}

const SPEED = 500.0
const JUMP_VELOCITY = -800.0
const SLOW_FALL_RATIO = 0.4
const GRAVITY_CORRECTION_RATIO = 2.5
const IN_THE_AIR_ACCELERATION_RATIO = 0.05

var facing:Facing = Facing.RIGHT

func _ready() -> void:
	facing = Facing.RIGHT
	sprite.change_facing(self)
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * GRAVITY_CORRECTION_RATIO

	# Handle jump.
	# If character is on floor and jump is pressed, initiate jump.
	# If character is in air and jump is pressed, apply slow fall.
	# Kinda like the mechnism in google dinosaur game.
	if Input.is_action_pressed("up"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		else:
			velocity -= get_gravity() * delta * SLOW_FALL_RATIO * IN_THE_AIR_ACCELERATION_RATIO


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")

	# Handle character walking.
	# Walk normally on ground.
	# Apply small amount of acceleration in the air.
	# But only in the opposite direction.
	if is_on_floor():
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED * 0.1)
	else:
		if sign(velocity.x) != sign(direction):
			velocity.x += direction * SPEED * 0.1 
	
	if not Input.is_action_pressed("gimick1"):
		if 0 < direction:
			if Facing.RIGHT != facing:
				facing = Facing.RIGHT
				sprite.change_facing(self)
			
		elif 0 > direction:
			if Facing.LEFT != facing:
				facing = Facing.LEFT
				sprite.change_facing(self)
	
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("menu"):
		get_tree().change_scene_to_file(menu_route)
	
	move_and_slide()
