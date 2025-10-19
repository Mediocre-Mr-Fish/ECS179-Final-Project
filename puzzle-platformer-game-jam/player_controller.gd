class_name PlayerController
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var anim_player = $AnimationPlayer


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim_player.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if direction == -1:
			$Sprite2D.flip_h = true
			scale.y == -1.0
		#rotation_degrees = 0.0
		#rotation_degrees = 180.0
		else:
			$Sprite2D.flip_h = false
			scale.y = 1.0
		anim_player.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim_player.play("idle")

	move_and_slide()
