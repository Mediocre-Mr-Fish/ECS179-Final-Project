class_name StaticObjectIndeterminate
extends ObjectIndeterminate

#@onready var animation_tree: AnimationTree = $AnimationTree
#@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite:Sprite2D = $Sprite2D
@onready var collision:CollisionShape2D = $CollisionShape2D
 
var existant: bool = false

func determinism_update()->void:
	if determined and existant:
		sprite.visible = true
		collision.set_deferred("disabled",false)
	elif determined and not existant:
		sprite.visible = false
		collision.set_deferred("disabled",true)

func on_camera(seen:bool, overlay:CameraController.Overlay = CameraController.Overlay.NONE)->void:
	if seen and not determined:
		print("I've been seen!")
		existant = true
		determined = true
		determinism_update()

func on_touch(touch:bool, object:Node2D)->void:
	if touch and not determined:
		print("I've been touched!")
		existant = false
		determined = true
		determinism_update()
