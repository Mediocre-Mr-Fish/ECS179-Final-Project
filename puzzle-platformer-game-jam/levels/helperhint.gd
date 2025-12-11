extends TabContainer


func _ready():
	visible = false
	current_tab = 0


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
