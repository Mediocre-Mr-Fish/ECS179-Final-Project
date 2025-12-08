extends CharacterBody2D

@export var SPEED = 10

var dir: float
var spawn_pos: Vector2
var spawn_rot: float
var zdex: int

func _ready():
	global_position = spawn_pos
	global_rotation = spawn_rot
	z_index = zdex
	print("arrow spawned at", global_position)

func _physics_process(delta):
	velocity = Vector2.RIGHT.rotated(dir) * SPEED
	var collision = move_and_collide(velocity)
	if collision != null:
		var body = collision.get_collider()
		print("hit")
		if body is PlayerController:
			body.take_damage(true) 
			print("player hit by arrow")
		queue_free()

func _on_life_timeout():
	queue_free()
