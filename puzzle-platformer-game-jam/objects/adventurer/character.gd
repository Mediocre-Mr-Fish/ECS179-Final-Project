class_name Character
extends CharacterBody2D

signal CharacterDirectionChange(facing: Facing)

enum Facing {
	LEFT,
	RIGHT,
}

const TERMINAL_VELOCITY := 700
const DEFAULT_JUMP_VELOCITY := -400
const DEFAULT_MOVE_VELOCITY := 300

var gravity: float = ProjectSettings.get("physics/2d/default_gravity")
var movement_speed := DEFAULT_MOVE_VELOCITY
var jump_velocity := DEFAULT_JUMP_VELOCITY

var facing: Facing = Facing.RIGHT
var _horizontal_input := 0.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@export var menu_route: String

var right_cmd : Command
var left_cmd : Command
var up_cmd : Command
var idle : Command


func _ready() -> void:
	change_facing(facing)


# Movement
func move(value: float) -> void:
	_horizontal_input = value


func change_facing(new_facing: Facing) -> void:
	if facing != new_facing:
		facing = new_facing
		emit_signal("CharacterDirectionChange", facing)
		sprite.flip_h = (facing == Facing.LEFT)


func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_jump()
	handle_horizontal_movement()
	handle_facing()
	update_animation() 
	move_and_slide()


func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = minf(velocity.y, TERMINAL_VELOCITY)


func handle_jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity


func handle_horizontal_movement() -> void:
	var direction := Input.get_axis("left", "right")

	if direction != 0:
		velocity.x = direction * movement_speed
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)


func handle_facing() -> void:
	if velocity.x > 10:
		change_facing(Facing.RIGHT)
	elif velocity.x < -10:
		change_facing(Facing.LEFT)

func update_animation() -> void:
	if not is_on_floor():
		play_anim("jump")
		return

	var dir := Input.get_axis("left", "right")
	if abs(dir) > 0:
		play_anim("move")
		return




# Prevent restarting animations every frame
func play_anim(title: String) -> void:
	if animation_player.current_animation != title:
		animation_player.play(title)


func handle_debug_controls() -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

	if Input.is_action_just_pressed("menu"):
		get_tree().change_scene_to_file(menu_route)
