extends TabBar

@export var sprite_animation:String
@onready var animated_sprite = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if sprite_animation:
		animated_sprite.play(sprite_animation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
