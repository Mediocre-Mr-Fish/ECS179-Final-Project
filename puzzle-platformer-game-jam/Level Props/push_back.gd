extends Sprite2D

var pushes: int = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
		pushes += 1
		var opacity_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
		var pos_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
		pos_tween.tween_property(self, "global_position", global_position + Vector2(-300, 0), 0.1)
		
		if pushes == 7:
			opacity_tween.tween_property(self, "modulate:a", 0.0, 0.5)
