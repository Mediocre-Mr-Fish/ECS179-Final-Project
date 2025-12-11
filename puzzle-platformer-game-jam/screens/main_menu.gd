extends Node2D

@onready var BGM_player: AudioStreamPlayer = get_node("/root/AutoloadAudioPlayer/BGMPlayer")


func _ready() -> void:
	BGM_player.scene_changed("menu")
	$start.scene_path = LevelMap.start_cutscene_path
