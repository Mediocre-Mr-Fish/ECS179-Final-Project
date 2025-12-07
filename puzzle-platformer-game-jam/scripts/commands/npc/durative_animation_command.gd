class_name DurativeAnimationCommand
extends RefCounted

enum Status {
	ACTIVE,
	DONE,
	ERROR
}

var _timer:Timer = null

func execute(character: Node) -> Status:
	return Status.ERROR


func _manage_durative_animation_command(character: Node, animation:String, duration:float = 0.0) -> Status:
	if _timer == null:
		var anim_tree = character.get_node("AnimationTree") as AnimationTree
		anim_tree["parameters/playback"].travel(animation)
		
		_timer = Timer.new()
		_timer.one_shot = true
		character.add_child(_timer)

		if !is_zero_approx(duration):
			_timer.start(duration)
		else:
			_timer.start(character.animation_player.current_animation_length)
		return Status.ACTIVE
	
	if !_timer.is_stopped():
		return Status.ACTIVE
	else:
		return Status.DONE
