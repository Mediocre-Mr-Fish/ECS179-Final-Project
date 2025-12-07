extends CharacterBody2D

@export var SPEED = -300

var dir: float
var spawn_pos : Vector2
var spawn_rot : float

func _ready():
	global_position = spawn_pos
	global_rotation = spawn_rot

func _physics_process(delta):
	velocity = Vector2(0, -SPEED).rotated(dir)
	move_and_slide()
