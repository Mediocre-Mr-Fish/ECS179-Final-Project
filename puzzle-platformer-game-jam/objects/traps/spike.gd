extends Area2D

@export var current_state: Spike_State
enum Spike_State {ACTIVE, ANIMATED}

func _process(delta):
	match current_state:
		Spike_State.ACTIVE:
			active()
		Spike_State.ANIMATED:
			active_animated()
			
func active():
	$animation.play("active")
	
func active_animated():
	$animation.play("activate")
	
func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		body.take_damage(1)
		print("player stepped on spike")
