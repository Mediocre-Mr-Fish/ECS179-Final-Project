class_name CameraController
extends Camera2D

@export var floating_offset:Vector2 = Vector2.ZERO
@export var shifted_offset:Vector2 = Vector2(600, 0)

@export var subject:PlayerController:
	set(value):
		if value:
			subject = value
			global_position = subject.global_position + floating_offset

@onready var overlay:Node = $Overlay
@onready var inventoryHandler = $"inventory handler"

func _ready() -> void:
	subject.filter_switch.connect(setColor)
	overlay.visible = false
	global_position = subject.global_position + floating_offset

func _process(_delta: float) -> void:
	if Input.is_action_pressed("look_in_direction"):
		if subject.Facing.RIGHT == subject.facing:
			global_position.x = subject.global_position.x + shifted_offset.x
		else:
			global_position.x = subject.global_position.x - shifted_offset.x
	else:
		global_position.x = subject.global_position.x + floating_offset.x
	
	if Input.is_action_pressed("filter_activate"):
		if subject.currentColor == null:
			return
		var overlapping_areas = $Area2D.get_overlapping_areas()
		for area in overlapping_areas:
			$Area2D._on_area_entered(area)

	if Input.is_action_just_pressed("filter_activate"):
		overlay.visible = true

	if Input.is_action_just_released("filter_activate"):
		overlay.visible = false

func setColor(color):
	overlay.modulate = colors.getColorFromEnum(color)
	inventoryHandler.switchColor(color)
