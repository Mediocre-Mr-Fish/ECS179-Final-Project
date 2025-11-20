class_name PlayerController
extends CharacterBody2D

#@onready var sprite:Sprite2D = $Sprite2D
@onready var sprite:PlayerSprite = $Sprite2D
@export var menu_route:String

enum Facing {
	LEFT,
	RIGHT,
}

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

var facing:Facing = Facing.RIGHT
var hasBeholder = false
var hasLasso = false
var hasTorch = false
var beholder:Array = []
var currentColor = null


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
	
	if not Input.is_action_pressed("look_in_direction"):
		if 0 < direction:
			if Facing.RIGHT != facing:
				facing = Facing.RIGHT
				sprite.change_facing(self)
			
		elif 0 > direction:
			if Facing.LEFT != facing:
				facing = Facing.LEFT
				sprite.change_facing(self)

	if Input.is_action_just_pressed("filter_switch"):
		print("filter")
		if not hasBeholder:
			return
		#if theres no current color, pick the first color gem player picked up
		if currentColor == null:
			print("no current color")
			if beholder == []: #player hasn't picked up any color gems
				return
			currentColor = beholder[0]
			return
		#get index of current color in the beholder
		var index = beholder.find(currentColor)
		print("next color: ", index)
		if index == -1:
			currentColor = beholder[0]
		#set the current color to the next one
		currentColor = beholder[(index+1)%beholder.size()]

	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("menu"):
		get_tree().change_scene_to_file(menu_route)
	
	move_and_slide()
