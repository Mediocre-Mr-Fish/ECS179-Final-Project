class_name ZoneOut
extends HurtBox


func on_touch(touched:bool, object:Node2D)->void:
	get_tree().reload_current_scene()
