class_name DashCommand
extends Command


func execute(character: Character) -> Status:
	if character.sprite.flip_h == true:
		character.position.x -= 100
	else:
		character.position.x += 100
	return Status.DONE
