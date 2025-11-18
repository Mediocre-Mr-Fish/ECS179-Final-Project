class_name LassoEnd
extends RigidBody2D

var active: bool = false

@onready var sprite: Sprite2D = $LassoEndSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	activate(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not active:
		return
	#linear_velocity += get_gravity() * delta
	move_and_collide(linear_velocity * delta)


func activate(a: bool) -> bool:
	active = a
	freeze = not active
	sprite.visible = active
	linear_velocity = Vector2.ZERO
	return active


func toss(toss_origin:CharacterBody2D, toss_force:Vector2) -> bool:
	if active:
		activate(false)
		#return false
	
	activate(true)
	global_position = toss_origin.global_position
	linear_velocity = toss_origin.velocity
	apply_impulse(toss_force)
	return true
