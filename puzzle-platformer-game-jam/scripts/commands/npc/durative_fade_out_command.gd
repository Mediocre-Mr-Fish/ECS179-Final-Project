class_name FadeOutCommand
extends DurativeAnimationCommand

@export var duration: float = 1.5
@export var target_alpha: float = 1.0

func _init(duration, target_alpha):
	self.duration = duration
	self.target_alpha = target_alpha
	
func execute(character) -> Status:
	var player = character as PlayerController
	
	var fade_node = player.get_node("../Fade") as ColorRect
	fade_node.visible = true
	
	if _timer == null:
		var tween = player.create_tween()
		tween.tween_property(fade_node,"modulate:a", target_alpha, duration)
		
		_timer = Timer.new()
		_timer.one_shot = true
		player.add_child(_timer)
		_timer.start(duration)
		
		
	return _manage_durative_animation_command(player, "fade", duration)
