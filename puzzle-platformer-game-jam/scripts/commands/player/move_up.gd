class_name JumpCommand
extends Command


func execute(character: Character) -> Status:
	var input = character.jump_velocity
	character.velocity.y = input
	return Status.DONE
	
