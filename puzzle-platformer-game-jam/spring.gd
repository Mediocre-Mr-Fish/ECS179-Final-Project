extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var activation_delay: float =  1.0

var is_activated = false

func _on_body_entered(body: Node2D) -> void:
	# Checks when the player enters the spring
	if body is PlayerController and not is_activated:
		is_activated = true
		await get_tree().create_timer(activation_delay).timeout
		
		# Verifies if the player is off the spring, then do not activate it
		if not self.overlaps_body(body):
			is_activated = false
			return
			
		animated_sprite_2d.play("bounce")
		body.spring_jump()

# 
func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "bounce":
		animated_sprite_2d.play("idle")
		is_activated = false
