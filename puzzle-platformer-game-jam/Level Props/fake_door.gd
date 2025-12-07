extends Sprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
		var opacity_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
		opacity_tween.tween_property(self, "modulate:a", 0.0, 0.5)
