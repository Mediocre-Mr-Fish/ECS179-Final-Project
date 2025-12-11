extends Node2D

const TIMER := 7.0

var images := []
var current := 0
var current_timer:SceneTreeTimer

func _ready():
	images = get_children()
	
	for img in images:
		img.visible = false
	
	_show_image(0)


@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		current_timer.timeout.disconnect(_on_timer_timeout)
		_on_timer_timeout()


func _on_timer_timeout() -> void:
	if current + 1 < images.size():
		images[current].visible = false
		_show_image(current + 1)
	else:
		get_tree().change_scene_to_file(LevelMap.get_first_level())
		current_timer.timeout.disconnect(_on_timer_timeout)


func _show_image(index):
	images[index].visible = true
	current = index
	current_timer = get_tree().create_timer(TIMER)
	current_timer.timeout.connect(_on_timer_timeout)
	
	
