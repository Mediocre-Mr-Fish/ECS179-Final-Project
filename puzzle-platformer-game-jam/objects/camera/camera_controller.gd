class_name CameraController
extends Camera2D

@export var floating_offset:Vector2 = Vector2.ZERO
@export var shifted_offset_horizontal:Vector2 = Vector2(550, 0)
@export var shifted_offset_up:Vector2 = Vector2(0, -300)
@export var shifted_offset_down:Vector2 = Vector2(0, 300)

@export var shift_speed:float = 2000.0

@export var subject:PlayerController:
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
	var target_position:Vector2 = subject.global_position
	if Input.is_action_pressed("gimick1"):
		if subject.facing == subject.Facing.RIGHT:
			target_position += shifted_offset_horizontal
		else:
			target_position -= shifted_offset_horizontal
		
		if subject.facing_y == subject.FacingY.UP:
			target_position += shifted_offset_up
		elif subject.facing_y == subject.FacingY.DOWN:
			target_position += shifted_offset_down
	else:
		target_position += floating_offset
	
	global_position += (target_position - global_position).limit_length(shift_speed * _delta)
	
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
