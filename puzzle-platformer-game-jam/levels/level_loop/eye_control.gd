class_name EyeControl
extends Sprite2D

@export var max_eye_offset_y: float = 0.0
@export var max_eye_offset_x: float = 0.0

@onready var player: Node2D = get_parent().get_parent().get_parent().get_parent().get_node("player")
@onready var painting: Node2D = get_parent(). get_parent()

var eye_position: Vector2 = Vector2.ZERO
var player_position: Vector2 = Vector2.ZERO

var player_dis_x: float = 0.0
var player_dis_y: float = 0.0

var _is_staring_at_painting: bool = true

func _ready() -> void:
	eye_position = painting.position

func _physics_process(delta: float) -> void:
	if _is_staring_at_painting:
		position.y = max_eye_offset_y
		_track_the_player()
	else: 
		pass
	
	


func _track_the_player() -> void:
	player_dis_x = player.position.x - painting.position.x
	player_dis_y = player.position.y - painting.position.y

	eye_position.x = player_dis_x * (max_eye_offset_y / player_dis_y)

	eye_position.x = clamp(eye_position.x, -max_eye_offset_x, max_eye_offset_x)
	position.x = eye_position.x

	print("Eye Position: ", eye_position, "Player distance X: ", player_dis_x, "Player distance Y: ", player_dis_y)
