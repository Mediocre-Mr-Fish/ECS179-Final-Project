extends Node2D

@export var player: Node = null

const TIMER := 7.0

var images := []
var current := 0

func _ready():
	player.is_control_enabled = false
	images = get_children()
	
	for img in images:
		img.visible = false
	
	_show_image(0)
	
func _show_image(index):
	images[index].visible = true
	current = index
	await get_tree().create_timer(TIMER).timeout
	
	if current + 1 < images.size():
		images[current].visible = false
		_show_image(current + 1)
	else:
		images[current].visible = false
		player.is_control_enabled = true
		
