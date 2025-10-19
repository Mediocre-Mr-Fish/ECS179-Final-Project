class_name CameraController
extends Camera2D

@export var floating_offset:Vector2 = Vector2.ZERO
@export var shifted_offset:Vector2 = Vector2(600, 0)

@export var subject:PlayerController :
	set(value):
		subject = value
		global_position = subject.global_position + floating_offset

func _ready() -> void:
	global_position = subject.global_position + floating_offset


func _process(_delta: float) -> void:
	if Input.is_action_pressed("gimick1"):
		if subject.Facing.RIGHT == subject.facing:
			global_position.x = subject.global_position.x + shifted_offset.x
		else:
			global_position.x = subject.global_position.x - shifted_offset.x
	else:
		global_position.x = subject.global_position.x + floating_offset.x
