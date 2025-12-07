class_name DurativeKnockbackCommand
extends DurativeAnimationCommand

var _knockback_status: bool = false
var _velocity: Vector2

func _init(velocity: Vector2):
	_velocity = velocity
	
func execute(character) -> Status:
	var player = character as PlayerController
	
	if !_knockback_status:
		print("knocked back")
		_knockback_status = true
		player.input_locked = false
		player.velocity = _velocity
		player.get_node("AnimationTree")["parameters/playback"].travel("jump")
		player.command_callback("jump")
		
	if player.is_on_floor() && _knockback_status:
		#player.velocity.x = 0
		player.input_locked = false
		return Status.DONE
	else:
		player.input_enabled = false
		
	return Status.ACTIVE
