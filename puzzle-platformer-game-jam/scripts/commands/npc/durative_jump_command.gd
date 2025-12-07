class_name DurativeJumpCommand
extends DurativeAnimationCommand

var _jump_started:bool = false
var _was_above_floor:bool = false
var _x_velocity:float = 0.0

func _init(x_velocity: float = 0):
	_x_velocity = x_velocity

func execute(character) -> Status:
	var player = character as PlayerController

	if player.is_on_floor() && !_jump_started:
		player.velocity.y = PlayerController.JUMP_VELOCITY
		player.velocity.x = _x_velocity
		_jump_started = true
		player.animation_tree["parameters/playback"].travel("jump")
		player.command_callback("run")
	elif !player.is_on_floor():
		_was_above_floor = true
	elif player.is_on_floor() && _was_above_floor:
		player.animation_tree["parameters/playback"].travel("idle")
		player.velocity.x = 0
		return Status.DONE
	
	return Status.ACTIVE
