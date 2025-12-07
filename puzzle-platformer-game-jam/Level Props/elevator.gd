extends TileMapLayer

var original_pos: Vector2
var down_pos: Vector2
var is_player_on: bool = false

func _ready() -> void:
	original_pos = global_position
	down_pos = original_pos + Vector2(0, 120)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and !is_player_on:
		is_player_on = true

		var t := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		t.tween_property(self, "global_position", down_pos, 0.5)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D and is_player_on:
		is_player_on = false

		var t := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		t.tween_property(self, "global_position", original_pos, 0.5)
