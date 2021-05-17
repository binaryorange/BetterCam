
extends Spatial

# Intro comment block
"""
	BetterCam is an all-purpose third-person camera solution with customizable attributes.
	The intention behind BetterCam is to provide any Godot user with a reusable, instantiable scene that 
	can be dropped into any project and instantly provide a better camera, allowing the end-user to focus 
	more on developing their game instead of reinventing the wheel. 
"""

# Enum descriptions
""" 
	CAM_FOLLOW_MODE lets the user choose between an instant camera (like old third-person shooters,
	where the camera would snap instantly either to clip against geometry or to return to its default
	position behind the player), or a nice smooth camera by using lerping to smoothly position the camera. 
	
	CAM_SMOOTH_STYLE lets the user choose between only smoothing out the camera movement when it's 
	returning to its non-clipping state, or to allow the camera to pull in and out while smoothing
	out the camera movement, similar to RDR2.
	
	CAM_TARGET lets the user OVERRIDE the default target in favor of a custom one, though this is
	NOT recommended, but could be useful if needed.
	
	CAM_DISTANCE_MODE lets the user choose between a camera that is positioned at a fixed distance from the player, 
	or a camera that can be positioned dynamically (allowing the player to zoom in/out, for example).
	
	INPUT_MODE allows the user to choose how to handle input to the camera. Either only mouse, gamepad, 
	or both! Also runs a secondary script ("CheckInputs.gd") that will generate input mappings to control the camera,
	so that the end-user does not have to manually put in the mappings themselves.
	
	INPUTS allows the user to choose whether or not to let BetterCam create the input bindings for them, 
	or if they want to manually add their own. 
"""
enum CAM_FOLLOW_MODE {INSTANT, SMOOTH} 
enum CAM_SMOOTH_STYLE {SMOOTH_IN_OUT, SMOOTH_OUT}
enum CAM_TARGET {DEFAULT, CUSTOM}
enum CAM_DISTANCE_MODE {FIXED_DISTANCE, DYNAMIC_DISTANCES}
enum INPUT_MODE {MOUSE, GAMEPAD, MOUSE_AND_GAMEPAD}
enum INPUTS {CREATE_FOR_ME, CUSTOM}


# These are publicly available variables that allow the user to choose certain parameters for their camera.

# Camera Settings
export (CAM_FOLLOW_MODE) var camera_follow_mode = CAM_FOLLOW_MODE.SMOOTH
export (CAM_SMOOTH_STYLE) var camera_smooth_style = CAM_SMOOTH_STYLE.SMOOTH_OUT
export (CAM_DISTANCE_MODE) var camera_distance_mode= CAM_DISTANCE_MODE.DYNAMIC_DISTANCES
export (CAM_TARGET) var camera_target = CAM_TARGET.DEFAULT
export var camera_smooth_speed : float = 0.03 
export var camera_minimum_distance_to_player : float = 1.0 
export var camera_rotation_speed : float = 1.0  

# Input settings
export (INPUT_MODE) var camera_input_mode = INPUT_MODE.MOUSE_AND_GAMEPAD
export (INPUTS) var camera_inputs = INPUTS.CREATE_FOR_ME
export var mouse_sensitivity : float = 1.0
export var mouse_deadzone : float = 0.1
export var joystick_sensitivity : float = 1.0
export var joystick_deadzone : float = 0.25

# These variables help us access the controlling nodes and are not accessible via the inspector
onready var _y_gimbal = $"."
onready var _x_gimbal = $XRotationHelper
onready var _springarm = $XRotationHelper/SpringArm

# This array will store objects that are close enough to the camera to warrant clipping
var _objects : Array = []

# This tells us when the camera can clip to geometry
var _can_clip : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Determine whether the mouse is free or not
	if camera_input_mode == INPUT_MODE.MOUSE_AND_GAMEPAD or camera_input_mode == INPUT_MODE.MOUSE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# Hide the visual aid
	$XRotationHelper/SpringArm/CameraTarget/TargetVisualAid.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
