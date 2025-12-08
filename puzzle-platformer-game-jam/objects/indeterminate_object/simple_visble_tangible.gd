class_name SimpleVisibleTangible
extends ObjectIndeterminate

enum Actions {
	MAKE_EXIST,
	MAKE_NONEXIST
}

## place all visual nodes in this array
@export var visuals:Array[CanvasItem]
## place all collision nodes in this array
@export var collisions:Array[CollisionShape2D]

## What this object does when on camera
@export var seen_action:Actions
## What this object does when touched
@export var touch_action:Actions

var existant:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	if seen_action == Actions.MAKE_EXIST:
		change_visibility(true)
	else:
		change_visibility(false)


func change_visibility(visibility: bool) -> void:
	for item in visuals:
		item.visible = visibility


func change_tangiblity(tangiblity: bool) -> void:
	for collision in collisions:
		collision.set_deferred("disabled", not tangiblity)


func determinism_update()->void:
	if determined and existant:
		change_visibility(true)
		change_tangiblity(true)
	elif determined and not existant:
		change_visibility(false)
		change_tangiblity(false)


func do_action(action:Actions) -> void:
	match action:
		Actions.MAKE_EXIST:
			existant = true
			determined = true
			determinism_update()
		Actions.MAKE_NONEXIST:
			existant = false
			determined = true
			determinism_update()


@warning_ignore("unused_parameter")
func on_camera(seen:bool) -> void:
	if seen and not determined:
		print("I've been seen!")
		do_action(seen_action)


func on_touch(touch:bool) -> void:
	print("I've been touched!")
	if touch and not determined:
		print("I've been touched!")
		do_action(touch_action)
