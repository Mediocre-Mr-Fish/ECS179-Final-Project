extends Node2D

#@onready var wall_bow = get_tree().get_root().get_node("Wall Bow")
@onready var sprite = $AnimatedSprite2D
@onready var arrow = load("res://scripts/traps/arrow.tscn")

func _ready():
	fire_anim()
	
func fire_anim():
	print("arrow debug1")
	sprite.animation = "firing"
	sprite.play()
	await sprite.animation_finished
	_on_animation_finished()
	
func _on_animation_finished():
	if sprite.animation == "firing":
		sprite.play("firing")
		print("arrow debug2")
		shoot()
		sprite.play("empty")
		await sprite.animation_finished
		
		if sprite.animation == "empty":
			print("arrow debug3")
			sprite.play("idle")
		
		
	
func shoot():
	var instance = arrow.instantiate()
	
	instance.dir = rotation
	instance.spawn_pos = global_position 
	instance.spawn_rot = global_rotation
	instance.zdex = z_index - 1

	get_parent().add_child(instance)
	print("arrow spawned")
