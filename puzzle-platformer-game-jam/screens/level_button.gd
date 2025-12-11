class_name Level_Labels
extends Control 

@onready var label = $TextureButton/BoxContainer/Label as Label
var index: int = 0
var scene_path: String

var original_position: Vector2

func _ready():
	set_number()
	original_position = label.position


func set_number():
	label.text = str(index).lpad(3)
	

func _on_texture_button_pressed() -> void:
	print(scene_path)
	get_tree().change_scene_to_file(scene_path)
