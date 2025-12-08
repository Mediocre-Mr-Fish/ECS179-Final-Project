class_name ThePainting
extends Node2D

@onready var fires: Node2D = $Fires

func _ready() -> void:
	pass


func set_on_fire() -> void:
	fires.visible = true
	print("The painting is now on fire!")
