class_name CameraController
extends Camera2D

@export var zoom_scale:float = 1.0

## the size of the pushbox
@export var pushbox_size:Vector2 = Vector2(500,500)
## the top left limit of the pushbox
@export var pushbox_top_left:Vector2 = Vector2(-250, -250)
## the bottom right limit of the pushbox
@export var pushbox_bot_right:Vector2 = Vector2(250, 250)

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

enum Overlay {
	NONE,
	GREEN,
}

var current_overlay:Overlay = Overlay.NONE
# pair of ints that describe camera shift direction. Values are only -1, 0, 1. Checked using <0, >0, ==0
var shift_tri_state: Vector2i = Vector2i.ZERO
var is_shifted: bool = false
var pushbox_position: Vector2 = Vector2.ZERO

@onready var overlay:Node = $Overlay
@onready var inventoryHandler = $"inventory handler"
@onready var camera_hit_box = $CameraHitBox


func _ready() -> void:
	subject.filter_switch.connect(setColor)
	zoom = Vector2.ONE * zoom_scale
	self.scale = Vector2.ONE / zoom_scale
	
	overlay.visible = false
	is_shifted = false
	shift_tri_state = Vector2.ZERO
	pushbox_position = Vector2.ZERO
	
	global_position = subject.global_position + floating_offset


func _camera_logic() -> void:
	var subject_offset:Vector2 = subject.global_position - global_position
	if subject_offset.x < pushbox_top_left.x:
		pass
	if subject_offset.x > pushbox_bot_right.x:
		pass

func _draw() -> void:
	var thickness:float = 3
	var color: Color = Color.BLACK
	
	var pushbox_limits: Rect2 = Rect2(pushbox_top_left, pushbox_bot_right - pushbox_top_left)
	draw_rect(pushbox_limits, color, false, thickness)
	

func _detect_shift() -> bool:
	var pressed:bool = Input.is_action_pressed("look_in_direction")
	if pressed and not is_shifted:
		@warning_ignore("narrowing_conversion")
		shift_tri_state.x = signf(Input.get_axis("left", "right"))
		@warning_ignore("narrowing_conversion")
		shift_tri_state.y = signf(Input.get_axis("up", "down"))
		is_shifted = true
	elif pressed:
		is_shifted = true
	else:
		shift_tri_state = Vector2i.ZERO
		is_shifted = false
	return pressed


func _process(_delta: float) -> void:
	var target_position:Vector2 = global_position
	if _detect_shift():
		target_position = subject.global_position
		if shift_tri_state.x > 0:
			target_position += shifted_offset_horizontal
		elif shift_tri_state.x < 0:
			target_position -= shifted_offset_horizontal
		
		if shift_tri_state.y < 0:
			target_position += shifted_offset_up
		elif shift_tri_state.y > 0:
			target_position += shifted_offset_down
	else:
		#target_position += floating_offset
		target_position = subject.global_position
	
	global_position += (target_position - global_position).limit_length(shift_speed * _delta)
	
	if Input.is_action_pressed("filter_activate"):
		if subject.currentColor == null:
			return
		var overlapping_areas = camera_hit_box.get_overlapping_areas()
		for area in overlapping_areas:
			camera_hit_box._on_area_entered(area)

	if Input.is_action_just_pressed("filter_activate"):
		overlay.visible = true

	if Input.is_action_just_released("filter_activate"):
		overlay.visible = false

func setColor(color):
	overlay.modulate = colors.getColorFromEnum(color)
	inventoryHandler.switchColor(color)
