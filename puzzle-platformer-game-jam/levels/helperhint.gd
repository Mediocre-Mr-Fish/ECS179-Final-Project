extends TabContainer

@onready var animated_sprite_flower = $Hint2/AnimatedSprite2D
@onready var animated_sprite_run = $Hint1/AnimatedSprite2D

func _ready():
	visible = false
	animated_sprite_flower.play("Green Flower")
	animated_sprite_run.play("Running")

func _input(event):
	if event.is_action_pressed("hint"):
		if visible:
			hide()
		else:
			_show_centered()

func _show_centered():
	visible = true
	var viewport_size = get_viewport().get_visible_rect().size
	var ui_size = size
	global_position = (viewport_size - ui_size) / 2
