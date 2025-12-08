class_name CameraController
extends Camera2D

@export var zoom_scale: float = 0.6

@export_group("Required Nodes")
@export var subject:PlayerController:
	set(value):
		if value:
			subject = value
			global_position = subject.global_position

@export_group("Pushbox")
## the size of the inner pushbox
@export var pushbox_size:Vector2 = Vector2(250,250)
## the top left limit of the pushbox
@export var pushbox_top_left:Vector2 = Vector2(-250, -250)
## the bottom right limit of the pushbox
@export var pushbox_bot_right:Vector2 = Vector2(250, 250)
## the speed that the inner pushbox moves inside the limits
@export var pushbox_speed: float = 100.0

@export_group("Shifting")
@export var shift_speed:float = 2000.0
@export var shifted_offset_horizontal:Vector2 = Vector2(550, 0)
@export var shifted_offset_up:Vector2 = Vector2(0, -300)
@export var shifted_offset_down:Vector2 = Vector2(0, 300)

var current_overlay:Colors.FilterColors
# pair of ints that describe camera shift direction. Values are only -1, 0, 1. Checked using <0, >0, ==0
var shift_tri_state: Vector2i = Vector2i.ZERO
var is_shifted: bool = false
var pushbox_position: Vector2 = Vector2.ZERO

@onready var overlay:Node = $Overlay
@onready var inventoryHandler = $"inventory_handler"
@onready var camera_hit_box = $CameraHitBox


static func _clamp_vec2_rect(value: Vector2, top_left: Vector2, bottom_right: Vector2) -> Vector2:
	return Vector2(
			clampf(value.x, top_left.x, bottom_right.x),
			clampf(value.y, top_left.y, bottom_right.y),
	)


func _ready() -> void:
	self.setZoom(zoom_scale, true)
	subject.filter_switch.connect(setColor)
	zoom = Vector2.ONE * zoom_scale
	self.scale = Vector2.ONE / zoom_scale
	
	overlay.visible = false
	is_shifted = false
	shift_tri_state = Vector2.ZERO
	pushbox_position = Vector2.ZERO
	
	global_position = subject.global_position


func _camera_logic(_delta:float) -> void:
	# where the subject is on the screen
	var subject_offset:Vector2 = subject.global_position - global_position
	var target_offset:Vector2 = subject_offset
	
	if (subject_offset.x < pushbox_position.x - pushbox_size.x / 2
			and subject.velocity.x < 0):
		pushbox_position.x = clampf(
				pushbox_position.x + pushbox_speed * _delta,
				pushbox_top_left.x,
				pushbox_bot_right.x,
		)
		
	if (subject_offset.x > pushbox_position.x + pushbox_size.x / 2
			and subject.velocity.x > 0):
		pushbox_position.x = clampf(
				pushbox_position.x - pushbox_speed * _delta,
				pushbox_top_left.x,
				pushbox_bot_right.x,
		)
	
	if (subject_offset.y < pushbox_position.y - pushbox_size.y / 2
			and subject.velocity.y < 0):
		pushbox_position.y = clampf(
				pushbox_position.y + pushbox_speed * _delta,
				pushbox_top_left.y,
				pushbox_bot_right.y,
		)
		
	if (subject_offset.y > pushbox_position.y + pushbox_size.y / 2
			and subject.velocity.y > 0):
		pushbox_position.y = clampf(
				pushbox_position.y - pushbox_speed * _delta,
				pushbox_top_left.y,
				pushbox_bot_right.y,
		)
	
	target_offset.x = clampf(
			target_offset.x,
			pushbox_position.x - pushbox_size.x / 2,
			pushbox_position.x + pushbox_size.x / 2,
	)
	target_offset.y = clampf(
			target_offset.y,
			pushbox_position.y - pushbox_size.y / 2,
			pushbox_position.y + pushbox_size.y / 2,
	)
		
	var target_position = subject.global_position - target_offset
	global_position += (target_position - global_position).limit_length(shift_speed * _delta)

func _shifted_camera_logic(_delta:float) -> void:
	var target_position:Vector2 = global_position
	target_position = subject.global_position
	if shift_tri_state.x < 0:
		target_position -= shifted_offset_horizontal / zoom_scale
		pushbox_position.x = pushbox_bot_right.x
	elif shift_tri_state.x > 0:
		target_position += shifted_offset_horizontal / zoom_scale
		pushbox_position.x = pushbox_top_left.x
	else:
		pushbox_position.x = 0
	
	if shift_tri_state.y < 0:
		target_position += shifted_offset_up / zoom_scale
		pushbox_position.y = pushbox_bot_right.y
	elif shift_tri_state.y > 0:
		target_position += shifted_offset_down / zoom_scale
		pushbox_position.y = pushbox_top_left.y
	else:
		pushbox_position.y = 0
	
	global_position += (target_position - global_position).limit_length(shift_speed * _delta  / zoom_scale)

func _draw() -> void:
	if not OS.is_debug_build():
		return
	
	var thickness:float = 3
	var color_limits: Color = Color.DARK_BLUE
	var color_box: Color = Color.BLACK
	
	var pushbox_limits: Rect2 = Rect2(
			pushbox_top_left * zoom_scale,
			(pushbox_bot_right - pushbox_top_left) * zoom_scale,
	)
	draw_rect(pushbox_limits, color_limits, false, thickness)
	
	var pushbox: Rect2 = Rect2(
			(pushbox_position - pushbox_size / 2) * zoom_scale,
			pushbox_size * zoom_scale,
	) 
	draw_rect(pushbox, color_box, false, thickness)


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
	if _detect_shift():
		_shifted_camera_logic(_delta)
	else:
		_camera_logic(_delta)
	
	if OS.is_debug_build():
		queue_redraw()
	
	if Input.is_action_pressed("filter_activate"):
		if subject.currentColor == null:
			return
		var overlapping_areas = camera_hit_box.get_overlapping_areas()
		for area in overlapping_areas:
			camera_hit_box._on_area_entered(area)

	if Input.is_action_just_pressed("filter_activate"):
		if subject.currentColor == null:
			return
		setColor(subject.currentColor)
		overlay.visible = true

	if Input.is_action_just_released("filter_activate"):
		overlay.visible = false


func setColor(color: Colors.FilterColors):
	current_overlay = color
	overlay.modulate = colors.getColorFromEnum(color)
	inventoryHandler.switchColor(color)
	
# A bridge func
func showCrown():
	$inventory_handler.showCrown()


func setZoom(new_zoom: float, is_init:bool = false) -> void:
	print("setting zoom: ", new_zoom)
	var ratio: float = new_zoom / self.zoom_scale
	if is_init:
		ratio = new_zoom
	pushbox_size /= ratio
	pushbox_top_left /= ratio
	pushbox_bot_right /= ratio
	self.zoom_scale = new_zoom
	self.zoom = Vector2.ONE * new_zoom
	self.scale = Vector2.ONE / new_zoom
	
	
