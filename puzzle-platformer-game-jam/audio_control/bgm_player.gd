class_name BGMPlayer
extends AudioStreamPlayer

@export var is_bgm_playing: bool = true
@export var main_menu_bgm:AudioStream
@export var level_one_bgm:AudioStream
@export var level_two_bgm:AudioStream
@export var level_three_bgm:AudioStream

var current_bgm:AudioStream = null

func _ready():
	
	print("BGM players:", get_tree().get_nodes_in_group("bgm").size())

	if main_menu_bgm == null:
		print("Warning: main_menu_bgm is not assigned.")
	if level_one_bgm == null:
		print("Warning: level_one_bgm is not assigned.")
	if level_two_bgm == null:
		print("Warning: level_two_bgm is not assigned.")
	if level_three_bgm == null:
		print("Warning: level_three_bgm is not assigned.")


func scene_changed(bgm_select: String) -> void:
	
	match bgm_select:
		# Main Menu and similar scenes
		"menu":
			stream = main_menu_bgm
		"levelselect":
			stream = main_menu_bgm
		"credits":
			stream = main_menu_bgm
		# Game Levels
		"item_testing":
			stream = level_one_bgm
		"Level1":
			stream = level_one_bgm
		"Level2":
			stream = level_two_bgm
		"Level3":
			stream = level_three_bgm
		_:
			stream = null

	if is_bgm_playing and stream != null and stream != current_bgm:
		stop()
		current_bgm = stream
		play()
	else:
		stop()
		
	
