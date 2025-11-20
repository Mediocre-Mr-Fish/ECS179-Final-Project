class_name SummonCommand
extends DurativeAnimationCommand


func execute(character:Character) -> Status:
	#make character visible
	character.sprite.visible = true
	
	#character is also revived to full health
	character.health = 100
	
	var status:Command.Status = _manage_durative_animation_command(character, "summon")
	return status
