class_name BridgeObjectIndeterminate
extends ObjectIndeterminate

#@onready var animation_tree: AnimationTree = $AnimationTree
#@onready var animation_player: AnimationPlayer = $AnimationPlayer
#@onready var sprite:Sprite2D = $Sprite2D
@onready var collision:CollisionShape2D = $CollisionShape2D
@onready var bridge:TileMapLayer = $Bridge_Sprite
@export var camera:CameraController
@export var objectColor:colors.FilterColors
@export var require_overlay: bool = true
@export var disable_collision_shape_when_inactive: bool = false

var existant: bool = true

func _ready() -> void:
	bridge.modulate = colors.getColorFromEnum(objectColor)

func _set_active(active: bool) -> void:
	bridge.visible = active
	bridge.collision_enabled = active
	if collision:
		collision.disabled = not active

func should_be_visible()->bool:
	if not camera or camera.subject == null:
		return false
	
	if objectColor != camera.subject.currentColor:
		return false
	
	if require_overlay:
		return camera.overlay.visible
	
	return true

func _process(delta: float) -> void:
	var active := should_be_visible() and existant
	bridge.visible = active
	if bridge.collision_enabled != active:
		bridge.collision_enabled = active
	
	if collision:
		if disable_collision_shape_when_inactive:
			# Defer toggling so the physics server updates cleanly mid-frame.
			collision.set_deferred("disabled", not active)
		else:
			# Default bridges keep their collision active regardless of tinting.
			if collision.disabled:
				collision.set_deferred("disabled", false)

func determinism_update()->void:
	if determined and existant:
		collision.set_deferred("disabled",false)
	elif determined and not existant:
		collision.set_deferred("disabled",true)

func on_camera(seen:bool)->void:
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
