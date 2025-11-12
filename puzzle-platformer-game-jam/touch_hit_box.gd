extends HitBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_area_entered(hurtbox: HurtBox) -> void:
	if hurtbox.has_method("on_touch"):
		hurtbox.on_touch(true, get_owner())


func _on_area_exited(hurtbox: HurtBox) -> void:
	if hurtbox.has_method("on_touch"):
		hurtbox.on_touch(false, get_owner())
