class_name PhysicsBox
extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mass = 0.5
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_touch(touch:bool, object:Node2D) -> void:
	print("bump")
	
