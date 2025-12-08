extends Area2D

@export var target_zoom: float = 1

func _on_body_entered(body):
	if body is PlayerController:
		print("changed zoom")
		var cam = get_node("../Camera2D") as CameraController
		cam.setZoom(target_zoom)
