class_name PlayerController
extends CharacterBody2D

#@onready var sprite:Sprite2D = $Sprite2D
@onready var sprite:PlayerSprite = $Sprite2D

enum Facing {
	LEFT,
	RIGHT,
}

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var facing:Facing = Facing.RIGHT

func _ready() -> void:
	facing = Facing.RIGHT
	sprite.change_facing(self)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if not Input.is_action_pressed("gimick1"):
		if 0 < direction:
			if Facing.RIGHT != facing:
				facing = Facing.RIGHT
				sprite.change_facing(self)
			
		elif 0 > direction:
			if Facing.LEFT != facing:
				facing = Facing.LEFT
				sprite.change_facing(self)

	move_and_slide()
