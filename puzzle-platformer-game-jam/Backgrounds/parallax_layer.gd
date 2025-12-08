extends ParallaxLayer

func _process(_delta):
	var cam := get_viewport().get_camera_2d()
	if cam:
		scale = cam.zoom
