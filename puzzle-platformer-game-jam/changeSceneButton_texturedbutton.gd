extends TextureButton

@export var scene_path: String


func _on_pressed() -> void:
	print(scene_path)
	get_tree().change_scene_to_file(scene_path)


func _on_button_pressed() -> void:
	pass # Replace with function body.


func _on_start_button_pressed() -> void:
	pass # Replace with function body.
