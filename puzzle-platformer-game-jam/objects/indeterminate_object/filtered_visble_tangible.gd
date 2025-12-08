class_name FilteredVisibleTangible
extends SimpleVisibleTangible

## the filter required to see this object
@export var seen_filter: Colors.FilterColors
## Automatically apply color modulation
@export var auto_modulate: bool = true

@onready var camera:CameraController = %Camera2D


func _ready() -> void:
	assert(camera, "Could not find camera. Make sure it is Acessable as a Unique Node!")
	super()
	if auto_modulate:
		for item in visuals:
			item.modulate = colors.getColorFromEnum(seen_filter)

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if should_be_visible() and existant:
		change_visibility(true)
	else:
		change_visibility(false)


func should_be_visible() -> bool:
	if not camera:
		return false
	return camera.overlay.visible and (seen_filter == camera.subject.currentColor)


func on_camera(seen:bool) -> void:
	if seen and should_be_visible() and not determined:
		print("I've been seen!")
		do_action(seen_action)
