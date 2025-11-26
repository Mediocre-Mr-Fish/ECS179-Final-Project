class_name BridgeObjectIndeterminate
extends ObjectIndeterminate

#@onready var animation_tree: AnimationTree = $AnimationTree
#@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite:Sprite2D = $Sprite2D
@onready var collision:CollisionShape2D = $CollisionShape2D
@onready var bridge:TileMapLayer = $Bridge_Sprite
@export var camera:CameraController

var existant: bool = true

func should_be_visible()->bool:
	if not camera:
		return false
	return CameraController.Overlay.GREEN == camera.current_overlay

func _process(delta: float) -> void:
	if should_be_visible() and existant:
		bridge.visible = true
		bridge.collision_enabled = true
	else:
		bridge.visible = false
		bridge.collision_enabled = false

func determinism_update()->void:
	if determined and existant:
		collision.set_deferred("disabled",false)
	elif determined and not existant:
		collision.set_deferred("disabled",true)

func on_camera(seen:bool, overlay:CameraController.Overlay = CameraController.Overlay.NONE)->void:
	if seen and should_be_visible() and not determined:
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
