extends TileMapLayer

@export var fall_delay := 0.3

func _ready() -> void:
	self.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	self.visible = true
	
	if body is CharacterBody2D:
		#await get_tree().create_timer(fall_delay).timeout
		var opacity_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
		var pos_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)

		opacity_tween.tween_property(self, "modulate:a", 0.0, 0.5)
		pos_tween.tween_property(self, "global_position", global_position + Vector2(-1000, 0), 0.5)
		opacity_tween.finished.connect(_disable_collider)
		
		
		#wait get_tree().create_timer(fall_delay).timeout
		#opacity_tween.finished.connect(_disable_collider)


		
func _disable_collider():
	collision_enabled = false
