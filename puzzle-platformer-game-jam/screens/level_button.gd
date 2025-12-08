class_name Level_Labels
extends Control 

@onready var label = $TextureButton/BoxContainer/Label as Label
@export var numbers : String = "Number"
@export var scene_path: String

var original_position: Vector2

func _ready():
	set_number()
	original_position = label.position

func set_number():
	label.text = "Unassigned"
	
	match numbers:
		"lvl1":
			label.text = "  1"
		"lvl2":
			label.text = "  2"
		"lvl3":
			label.text = "  3"
		"lvl4":
			label.text = "  4"
		"lvl5":
			label.text = "  5"
		"lvl6":
			label.text = "  6"
		"lvl7":
			label.text = "  7"
		"lvl8":
			label.text = "  8"
		"lvl9":
			label.text = "  9"
		"lvl10":
			label.text = " 10"
		"lvl11":
			label.text = " 11"
		"lvl12":
			label.text = " 12"
		"lvl13":
			label.text = " 13"
		"lvl14":
			label.text = " 14"
		"lvl15":
			label.text = " 15"
		"lvl16":
			label.text = " 16"
		"lvl17":
			label.text = " 17"
		"lvl18":
			label.text = " 18"
		"lvl19":
			label.text = " 19"
		"lvl20":
			label.text = " 20"

func _on_texture_button_pressed() -> void:
	print(scene_path)
	get_tree().change_scene_to_file(scene_path)
