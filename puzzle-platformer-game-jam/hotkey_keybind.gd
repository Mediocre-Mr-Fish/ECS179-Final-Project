class_name HotkeyRebinding
extends Control

@onready var label = $HBoxContainer/Label as Label
@onready var button = $HBoxContainer/Button as Button

@export var action_name : String = "left"

func _ready():
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()
	
func set_action_name() -> void:
	label.text = "Unassigned"
	match action_name:
		"left":
			label.text = "Move Left"
		"right":
			label.text = "Move Right"
		"up":
			label.text = "Jump"
		"look_in_direction":
			label.text = "Camera Shift"
		"filter_activate":
			label.text = "Filter Active"
		"filter_switch":
			label.text = "Switch Filter"
		"restart":
			label.text = "Reset"
		"menu":
			label.text = "Menu"

func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	# print(action_events)
	
	if action_events.is_empty():
		button.text = "Unassigned"
		return
		
	var event = action_events[0]

	if event is InputEventKey:
		var key_string = OS.get_keycode_string(event.physical_keycode)
		# print(key_string)
		button.text = key_string
	else:
		button.text = "Not a key"
	


func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		button.text = "Press any key"
		set_process_unhandled_key_input(true)

		for i in get_tree().get_nodes_in_group("Hotkey Buttons Groups"):
			if i.action_name != self.action_name:
				i.button.set_pressed_no_signal(false)
				i.set_process_unhandled_key_input(false)
	else:
		for i in get_tree().get_nodes_in_group("Hotkey Buttons Groups"):
			if i.action_name != self.action_name:
				i.button.set_pressed_no_signal(false)
				i.set_process_unhandled_key_input(false)

		set_process_unhandled_key_input(false)
		set_text_for_key()

func _unhandled_key_input(event):
	rebind_action_key(event)
	button.button_pressed = false

func rebind_action_key(event) -> void:
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	
	set_process_unhandled_key_input(false)
	set_text_for_key()
	set_action_name()
	
	
