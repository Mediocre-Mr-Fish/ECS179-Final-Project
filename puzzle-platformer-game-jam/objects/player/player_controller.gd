class_name PlayerController
extends CharacterBody2D

#@onready var sprite:Sprite2D = $Sprite2D
@onready var sprite:PlayerSprite = $Sprite2D
@export var menu_route:String
@export var pushForce:float = 100.0

@onready var animation_tree:AnimationTree = $AnimationTree

enum Facing {
	LEFT,
	RIGHT,
}
enum FacingY{
	UP,
	NEUTRAL,
	DOWN,
}

const SPEED = 500.0
const JUMP_VELOCITY = -800.0
const SLOW_FALL_RATIO = 0.4
const GRAVITY_CORRECTION_RATIO = 2.5
const IN_THE_AIR_ACCELERATION_RATIO = 0.05

var facing:Facing = Facing.RIGHT
var facing_y:FacingY = FacingY.NEUTRAL


func _ready() -> void:
	facing = Facing.RIGHT
	facing_y = FacingY.NEUTRAL
	sprite.change_facing(self)
	animation_tree.active = true
	

func _physics_process(delta: float) -> void:
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
	
	if not Input.is_action_pressed("gimick1"):
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
	elif is_on_floor():
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/run"] = false
	#elif not is_on_floor():
		#pass
		
