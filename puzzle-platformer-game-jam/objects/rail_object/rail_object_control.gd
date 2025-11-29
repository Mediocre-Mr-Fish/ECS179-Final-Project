@tool # Allows editing in the editor
extends Node2D

@export var rail_length: float = 500.0:
	set(value):
		rail_length = value
		_update_rail()

@export var rail_object_gravity_scale: float = 1.0:
	set(value):
		rail_object_gravity_scale = value
		_update_rail()

@export var rail_object_texture: Texture2D:
	set(value):
		rail_object_texture = value
		_update_rail()


var rail_object: RigidBody2D
var groove: GrooveJoint2D
var sprite: Sprite2D


# Called when the node is ready.
func _ready() -> void:
	rail_object = $RailObjectRigidBody2D
	groove = $RailObjectGrooveJoint2D
	sprite = $RailObjectSprite2D
	
	_update_rail()


func _update_rail() -> void:
	# Make sure nodes exist before accessing them
	if not is_inside_tree():
		return
	
	# Get nodes if not already assigned
	# Only get once to get better performance
	if rail_object == null:
		rail_object = get_node_or_null("RailObjectRigidBody2D")
	if groove == null:
		groove = get_node_or_null("RailObjectGrooveJoint2D")
	if sprite == null:
		sprite = get_node_or_null("RailObjectSprite2D")
	
	# Safety checks
	if rail_object == null or groove == null or sprite == null:
		return
	
	# Set rail object properties
	# Gravity scale
	rail_object.gravity_scale = rail_object_gravity_scale
	# Rail length
	groove.length = rail_length
	groove.position.x = rail_length / 2
	groove.initial_offset = rail_length / 2
	# Set texture
	sprite.texture = rail_object_texture
