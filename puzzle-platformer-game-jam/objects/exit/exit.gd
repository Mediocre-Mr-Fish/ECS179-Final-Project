extends HurtBox

## DEPRICATION WARNING
## Setting this property no longer has any effect,
## It is still exported to prevent scene corruption during merges 
@export var scene_path:String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var current_scene:String = get_tree().current_scene.scene_file_path
	print(current_scene)
	self.scene_path = LevelMap.get_next_level(current_scene)


@warning_ignore("unused_parameter")
func on_touch(touch:bool)->void:
	get_tree().change_scene_to_file(scene_path)
