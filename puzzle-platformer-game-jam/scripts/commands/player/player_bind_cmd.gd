class_name PlayerBind
extends DurativeAnimationCommand

func execute(player: Character) -> Command.Status:
	player.bind_player_input_commands()
	return _manage_durative_animation_command(player, "idle", 0.1)
