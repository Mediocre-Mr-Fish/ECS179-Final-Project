class_name PhysicsBox
extends RigidBody2D

@export var size:int = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mass = 0.5
	lock_rotation = true
	#resize hitbox
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$CollisionShape2D.shape.set_size(Vector2(size, size))
	#resize sprite
	var scaled_width = $CollisionShape2D/Sprite2D.texture.get_width() * $CollisionShape2D/Sprite2D.scale.x 
	var scaled_height = $CollisionShape2D/Sprite2D.texture.get_height() * $CollisionShape2D/Sprite2D.scale.y 
	$CollisionShape2D/Sprite2D.scale = Vector2(size/scaled_width, size/scaled_height)
	#resize boxHurtBox
	#resize boxHitBox


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_touch(touch:bool, object:Node2D) -> void:
	print("bump")
	
	
