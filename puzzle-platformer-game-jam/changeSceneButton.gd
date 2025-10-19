extends Button

@export var target_scene: PackedScene


func _on_pressed() -> void:
	print(target_scene)
	get_tree().change_scene_to_packed(target_scene)


func _on_button_pressed() -> void:
	pass # Replace with function body.
