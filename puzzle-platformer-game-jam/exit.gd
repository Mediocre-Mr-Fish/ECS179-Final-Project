extends HurtBox

@export var sceneFileLocation = "res://Level2.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func on_touch(touch:bool)->void:
	get_tree().change_scene_to_file(sceneFileLocation)
