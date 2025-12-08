extends ParallaxBackground

@export var zoom_scale: float = 1.0

func _process(_delta):
	var cam = get_viewport().get_camera_2d()
	if not cam:
		return

	var z = cam.zoom * zoom_scale

	for layer in get_children():
		for child in layer.get_children():
			if child is Sprite2D:
				child.scale = z
