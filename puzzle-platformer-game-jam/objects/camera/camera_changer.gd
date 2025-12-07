class_name CameraChangerBox
extends HitBox

@export var zoom_start = 1.0
@export var zoom_end = 1.0

var player_in_area:bool = false
var axis: Vector2
var axis_length: float
var shape_pos: Vector2

@onready var camera: CameraController = %Camera2D
@onready var player: PlayerController = %player


func _ready() -> void:
	var col_shape = $CollisionShape2D
	shape_pos = col_shape.global_position
	if col_shape.shape is RectangleShape2D:
		var rect = col_shape.shape as RectangleShape2D
		axis = Vector2.RIGHT * rect.size.x
		axis = axis.rotated(col_shape.rotation)
		axis_length = rect.size.x


func _init() -> void:
	super()
	collision_layer = 0
	collision_mask = 1
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


func _process(delta: float) -> void: 
	if not (camera and player and player_in_area):
		return
	if player.velocity.is_zero_approx():
		return
	
	## vector to player along self.axis
	var projected_offset:Vector2 = (player.global_position - self.shape_pos).project(self.axis)
	## Distance to player as a float
	var offset_x:float = projected_offset.length()
	# invert if in opposite direction
	if projected_offset.dot(self.axis) < 0:
		offset_x *= -1
	
	var relative_x:float = clampf((offset_x + axis_length / 2) / axis_length, 0, 1)
	#print(self.zoom_start, " ", self.zoom_end, " ", relative_x)
	camera.setZoom(lerpf(self.zoom_start, self.zoom_end, relative_x))

func _on_area_entered(hurtbox: HurtBox) -> void:
	if camera and player and hurtbox.get_owner() is PlayerController:
		player_in_area = true


func _on_area_exited(hurtbox: HurtBox) -> void:
	if camera and player and hurtbox.get_owner() is PlayerController:
		player_in_area = false
