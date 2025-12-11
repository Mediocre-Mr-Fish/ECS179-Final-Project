extends Node

var levels: Array[String] = [
		"res://levels/Area1/Level-1-1_Run_And_Jump.tscn",
		"res://levels/Area1/Level-1-2_Spikes.tscn",
		"res://levels/Area2/Level-2-1_Eyes.tscn",
		"res://levels/Area2/Level-2-2_Wall.tscn",
		"res://levels/Area2/Level-2-3_Leap_Of_Faith.tscn",
		"res://levels/Area3/Level-3-1_Green.tscn",
		"res://levels/Area3/Level-3-2_Bridge.tscn",
		"res://levels/Area3/Level-3-3_Green_Wall.tscn",
		"res://levels/level5_brian.tscn",
		"res://levels/Level6.tscn",
		"res://levels/Level4_tho.tscn",
		"res://levels/level_loop/LevelLoop.tscn",
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for level in levels:
		assert(ResourceLoader.exists(level), "Could not find level \"" + level + "\"")
