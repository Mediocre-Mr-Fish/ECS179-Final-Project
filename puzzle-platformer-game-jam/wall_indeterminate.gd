class_name StaticObjectIndeterminate
extends StaticBody2D

#@onready var animation_tree: AnimationTree = $AnimationTree
#@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite:Sprite2D = $Sprite2D
@onready var collision:CollisionShape2D = $CollisionShape2D
 
var determined: bool = false
var existant: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	determinism_update()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func determinism_update()->void:
	if determined and existant:
		sprite.visible = true
		#collision.disabled = false
		collision.set_deferred("disabled",false)
	elif determined and not existant:
		sprite.visible = false
		#collision.disabled = true
		collision.set_deferred("disabled",true)

func on_camera(seen:bool)->void:
	if seen and not determined:
		print("I've been seen!")
		existant = true
		determined = true
		determinism_update()

func on_touch(touch:bool)->void:
	if touch and not determined:
		print("I've been touched!")
		existant = false
		determined = true
		determinism_update()
