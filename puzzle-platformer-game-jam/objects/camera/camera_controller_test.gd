class_name CameraControllerTest
extends Camera2D

@export var floating_offset:Vector2 = Vector2.ZERO
@export var shifted_offset:Vector2 = Vector2(600, 0)

@export var subject:Character:
	set(value):
		if value:
			subject = value
			global_position = subject.global_position + floating_offset

@onready var overlay:Node = $Overlay

enum Overlay{
	NONE,
	GREEN,
}

var current_overlay:Overlay = Overlay.NONE

func _ready() -> void:
	overlay.visible = false
	global_position = subject.global_position + floating_offset


func _process(_delta: float) -> void:
	if Input.is_action_pressed("gimick1"):
		if subject.Facing.RIGHT == subject.facing:
			global_position.x = subject.global_position.x + shifted_offset.x
		else:
			global_position.x = subject.global_position.x - shifted_offset.x
	else:
		global_position.x = subject.global_position.x + floating_offset.x
	
	if Input.is_action_pressed("gimick2"):
		overlay.visible = true
		current_overlay = Overlay.GREEN
		var overlapping = $Area2D.get_overlapping_areas()
		for area in overlapping:
			$Area2D._on_area_entered(area)
	else:
		overlay.visible = false
		current_overlay = Overlay.NONE
		var overlapping = $Area2D.get_overlapping_areas()
		for area in overlapping:
			$Area2D._on_area_entered(area)
