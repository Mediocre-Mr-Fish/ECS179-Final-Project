class_name HitBox
extends Area2D

func _init() -> void:
	collision_layer = 0
	collision_mask = 8
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(hurtbox: HurtBox) -> void:
	if hurtbox.has_method("hit_by_hitbox"):
		hurtbox.hit_by_hitbox(self)

func _on_area_exited(hurtbox: HurtBox) -> void:
	pass
