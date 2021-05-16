extends Node

""" 
	This script checks for the inputs needed for this scene to work. It runs only once.
	If it doesn't find the inputs, it adds them along with the deadzones which you 
	can tweak through the "BetterCam" script variables "mouse deadzone" 
	and "joystick deadzone".
"""

# Store the parent 
onready var BC = $"../"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if BC.CreateInputsForMe:
	
		# We check for every input to prevent possible errors/duplicates.
		# A little cumbersome but worth it in the end!
		
		# First check for horizontal rotation, add it if it doesn't exist
		
		# Left rotation
		if !InputMap.has_action("cam_look_left"):
			InputMap.add_action("cam_look_left", BC.JoystickDeadzone)
			var event = InputEventJoypadMotion.new()
			event.axis = JOY_AXIS_2
			event.axis_value = -1.0
			InputMap.action_add_event("cam_look_left", event)
		
		# Right rotation
		if !InputMap.has_action("cam_look_right"):
			InputMap.add_action("cam_look_right", BC.JoystickDeadzone)
			var event = InputEventJoypadMotion.new()
			event.axis = JOY_AXIS_2
			event.axis_value = 1.0
			InputMap.action_add_event("cam_look_right", event)
		
		# Now check for the vertical rotation, if it doesn't exist add it
		
		# Up rotation
		if !InputMap.has_action("cam_look_up"):
			InputMap.add_action("cam_look_up", BC.JoystickDeadzone)
			var event = InputEventJoypadMotion.new()
			event.axis = JOY_AXIS_3
			event.axis_value = -1.0
			InputMap.action_add_event("cam_look_up", event)
		
		# Down rotation
		if !InputMap.has_action("cam_look_down"):
			InputMap.add_action("cam_look_down", BC.JoystickDeadzone)
			var event = InputEventJoypadMotion.new()
			event.axis = JOY_AXIS_3
			event.axis_value = 1.0
			InputMap.action_add_event("cam_look_down", event)
		
		
		# Now add zoom support
		
		# Gamepad bindings
		if !InputMap.has_action("zoom"):
			InputMap.add_action("zoom", BC.JoystickDeadzone)
			var event = InputEventJoypadButton.new()
			event.button_index = 10
			InputMap.action_add_event("zoom", event)
		
		# Mouse bindings
		if !InputMap.has_action("mouse_zoom_out"):
			InputMap.add_action("mouse_zoom_out", BC.MouseDeadzone)
			var event = InputEventMouseButton.new()
			event.button_index = BUTTON_WHEEL_DOWN
			InputMap.action_add_event("mouse_zoom_out", event)
			
		# Now that we're done, inform the user
		print("Input mappings have been created!")
		print(InputMap.get_actions())
		push_warning("Input mappings have been created!")
	else:
		printerr("Input mapping for BetterCam has failed! Please make sure 'Create Inputs For Me' is checked!")
		push_error("Input mapping for BetterCam has failed! Please make sure 'Create Inputs For Me' is checked!")
		get_tree().quit()
