class_name InteractionPrompt
extends Node2D

@export var player: Node2D = null
@export var visible_distance: float = 100.0

func _physics_process(delta: float) -> void:
	if player == null:
		return
	
	var distance_to_player: float = position.distance_to(player.position)
	
	if distance_to_player < visible_distance:
		visible = true
	else:
		visible = false
		
	return
