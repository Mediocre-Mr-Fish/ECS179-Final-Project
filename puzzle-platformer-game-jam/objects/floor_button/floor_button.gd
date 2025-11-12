class_name FloorButton
extends Node2D

@export var push_translation: Vector2 = Vector2(0, 32.0)
var num_weights: int = 0
@onready var sprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	num_weights = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_touch(touched:bool, object:Node2D) -> void:
	var prev_weights:int = num_weights
	if touched:
		num_weights += 1
	else:
		num_weights -= 1

	print("there are ", num_weights, " things on this button")
	if prev_weights <= 0 and num_weights > 0:
		position += push_translation
	elif prev_weights > 0 and num_weights <= 0:
		position -= push_translation
