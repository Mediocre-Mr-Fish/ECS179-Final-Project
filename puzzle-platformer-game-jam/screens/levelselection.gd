extends Node2D

@onready var button_container := %ButtonContainer
@onready var button_template := %LevelButtonTemplate


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for level_index in len(LevelMap.levels):
		var button := button_template.duplicate()
		button_container.add_child(button)
		button_container.move_child(button, -2) # to keep the HSeperator2 at the en
		button.index = level_index + 1
		button.scene_path = LevelMap.levels[level_index]
		button.set_number()
	#button_container.add_child(HSeparator.new())
