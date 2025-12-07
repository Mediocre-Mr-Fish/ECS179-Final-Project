class_name TPTrigger
extends Area2D

@onready var level_loop:LevelLoop = get_parent()

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("TPGroup"):
		return
	
	if position.x < 0:
		level_loop.tp_player_to_right_end()
	else:
		level_loop.tp_player_to_left_end()
		
