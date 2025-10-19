extends Button

@export var scenePath = "res://menu.tscn"


func _on_pressed() -> void:
	print(scenePath)
	get_tree().change_scene_to_file(scenePath)
