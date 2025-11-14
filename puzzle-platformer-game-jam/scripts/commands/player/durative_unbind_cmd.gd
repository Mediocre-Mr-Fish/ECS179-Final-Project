class_name PlayerUnbind
extends DurativeAnimationCommand

func execute(player: Adventurer) -> Command.Status:
	player.unbind_player_input_commands()
	return _manage_durative_animation_command(player, "idle", 2.0)
