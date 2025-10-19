class_name HurtBox
extends Area2D

func _init() -> void:
	collision_layer = 32 + 8
	collision_mask = 0

#not used yet
func get_hit(damage)->void:
	#print("I got hit!")
	if self.get_owner().has_method("take_damage"):
		self.owner.take_damage(damage)

func on_camera(seen:bool, overlay:CameraController.Overlay = CameraController.Overlay.NONE)->void:
	#print("I'm on camera!")
	if self.get_owner().has_method("on_camera"):
		self.owner.on_camera(seen, overlay)

func on_touch(touched:bool)->void:
	if self.get_owner().has_method("on_touch"):
		self.owner.on_touch(touched)
