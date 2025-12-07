class_name DurativeDeathCommand
extends DurativeAnimationCommand

func execute(character) -> Status:
	var player = character as PlayerController
	player.input_enabled = false
	player.get_node("PlayerSprite2D").visible = false
	player.get_node("Death").visible = true
	player.get_node("AnimationTree")["parameters/playback"].travel("death")
	
	return _manage_durative_animation_command(player, "death", 2.0)
