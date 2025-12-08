extends TileMapLayer

@export var fall_delay := 2
var has_fallen: bool = false

func _ready() -> void:
	self.visible = false
	collision_enabled = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("SEEE MEEE")
	self.visible = true
	collision_enabled = true

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		await get_tree().create_timer(fall_delay).timeout
		var pos_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
		pos_tween.tween_property(self, "global_position", global_position+Vector2(0, -2000), 0.5)
