class_name CameraHitBox
extends HitBox

@export var camera:CameraController


func _init() -> void:
	collision_layer = 0
	collision_mask = 32
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(hurtbox: HurtBox) -> void:
	if hurtbox.has_method("on_camera"):
		hurtbox.on_camera(true)

func _on_area_exited(hurtbox: HurtBox) -> void:
	if hurtbox.has_method("on_camera"):
		hurtbox.on_camera(false)
