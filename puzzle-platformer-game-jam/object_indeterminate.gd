class_name ObjectIndeterminate
extends Node2D

var determined: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	determinism_update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func determinism_update()->void:
	pass


func on_camera(seen:bool, overlay:CameraController.Overlay = CameraController.Overlay.NONE)->void:
	pass


func on_touch(touch:bool, object:Node2D)->void:
	pass
