class_name HurtBox
extends Area2D

func _init() -> void:
	collision_layer = 32 + 8
	collision_mask = 0

#not used yet
func get_hit(damage)->void:
	#print("I got hit!")
	if self.get_parent().has_method("take_damage"):
		self.get_parent().take_damage(damage)

func on_camera(seen:bool)->void:
	#print("I'm on camera!")
	if self.get_parent().has_method("on_camera"):
		self.get_parent().on_camera(seen)

func on_touch(touched:bool)->void:
	if self.get_parent().has_method("on_touch"):
		self.get_parent().on_touch(touched)
