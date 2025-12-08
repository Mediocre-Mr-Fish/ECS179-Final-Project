extends Node2D

@onready var wall_bow = get_tree().get_root().get_node("Wall Bow")
@onready var arrow = load("res://scripts/traps/arrow.tscn")

func _ready():
	shoot()
	
func shoot():
	var instance = arrow.instantiate()
	
	instance.dir = rotation
	instance.spawn_pos = global_position
	instance.spawn_rot = global_rotation
	instance.zdex = z_index - 1
	call_deferred("add_child", instance)
	print("arrow spawned")
	get_parent().add_child(instance)
