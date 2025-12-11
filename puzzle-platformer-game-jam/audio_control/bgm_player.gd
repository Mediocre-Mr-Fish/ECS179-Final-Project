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
	print("scene_changed called with: ", bgm_select)
	print("Currently playing: ", playing, " current_bgm: ", current_bgm)
	
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
			stream = main_menu_bgm

	if is_bgm_playing and stream != null:
		if stream != current_bgm:
			# Only stop and restart if it's a different BGM
			print("Switching BGM from ", current_bgm, " to ", stream)
			stop()
			current_bgm = stream
			play()
		else:
			# If stream == current_bgm, keep playing (or restart if stopped)
			print("Same BGM, continuing playback. Playing: ", playing)
			if not playing:
				print("BGM was stopped, restarting...")
				play()
	else:
		# Stop if BGM is disabled or no stream
		print("Stopping BGM")
		stop()
		current_bgm = null
		
		
		
	
