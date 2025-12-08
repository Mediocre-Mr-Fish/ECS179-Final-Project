extends CharacterBody2D

@export var SPEED = 3

var dir: float
var spawn_pos : Vector2
var spawn_rot : float
var zdex : int

func _ready():
	global_position = spawn_pos
	global_rotation = spawn_rot
	z_index = zdex
	print("arrow spawned at", global_position)

func _physics_process(delta):
	#velocity = Vector2(0, -SPEED).rotated(dir)
	velocity = Vector2.RIGHT.rotated(dir) * SPEED
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("hit")
	queue_free()
	
func _on_life_timeout():
	queue_free()
