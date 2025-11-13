extends ObjectIndeterminate

enum Actions {
	MAKE_EXIST,
	MAKE_NONEXIST
}

@export var visuals:Array[CanvasItem]
@export var collisions:Array[CollisionShape2D]

@export var seen_action:Actions
@export var touch_action:Actions

var existant:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func determinism_update()->void:
	if determined and existant:
		for item in visuals:
			item.visible = true
		for collision in collisions:
			collision.set_deferred("disabled", false)
	elif determined and not existant:
		for item in visuals:
			item.visible = false
		for collision in collisions:
			collision.set_deferred("disabled", true)


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


func on_camera(seen:bool, overlay:CameraController.Overlay = CameraController.Overlay.NONE) -> void:
	if seen and not determined:
		print("I've been seen!")
		do_action(seen_action)


func on_touch(touch:bool, object:Node2D) -> void:
	print("I've been touched!")
	if touch and not determined:
		print("I've been touched!")
		do_action(touch_action)
