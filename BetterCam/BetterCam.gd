extends Spatial

# Intro comment block
"""
	BetterCam is an all-purpose third-person camera solution with customizable attributes.
	The intention behind BetterCam is to provide any Godot user with a reusable, instantiable scene that 
	can be dropped into any project and instantly provide a better camera, allowing the end-user to focus 
	more on developing their game instead of reinventing the wheel. 
"""

# Enum descriptions and why they're here
""" 
	CAM_FOLLOW_MODE lets the user choose between an instant camera (like old third-person shooters,
	where the camera would snap instantly either to clip against geometry or to return to its default
	position behind the player), or a nice smooth camera by using lerping to smoothly position the camera. 
	
	CAM_SMOOTH_STYLE lets the user choose between only smoothing out the camera movement when it's 
	returning to its non-clipping state, or to allow the camera to pull in and out while smoothing
	out the camera movement, similar to RDR2.
	
	CAMERA_TARGET lets the user OVERRIDE the default target in favor of a custom one, though this is
	NOT recommended, but could be useful if needed.
	
	INPUT_MODE allows the user to choose how to handle input to the camera. Either only mouse, gamepad, 
	or both! Also runs a secondary script ("CheckInputs.gd") that will generate input mappings to control the camera,
	so that the end-user does not have to manually put in the mappings themselves.
"""
enum CAM_FOLLOW_MODE {INSTANT, SMOOTH} 
enum CAM_SMOOTH_STYLE {SMOOTH_IN_OUT, SMOOTH_OUT}
enum CAM_TARGET {DEFAULT, CUSTOM}
enum INPUT_MODE {MOUSE, GAMEPAD, MOUSE_AND_GAMEPAD}


# These are publicly available variables that allow the user to choose certain parameters for their camera.
export (CAM_FOLLOW_MODE) var CameraFollowMode = CAM_FOLLOW_MODE.SMOOTH
export (CAM_SMOOTH_STYLE) var CameraSmoothStyle = CAM_SMOOTH_STYLE.SMOOTH_OUT
export (CAM_TARGET) var CameraTarget = CAM_TARGET.DEFAULT
export var CameraSmoothSpeed : float = 0.03 
export var CameraMinimumDistance : float = 1.0 
export var CameraRotationSpeed : float = 1.0  
export (INPUT_MODE) var CameraInputMode = INPUT_MODE.MOUSE_AND_GAMEPAD

export var MouseSensitivity : float = 1.0
export var MouseDeadzone : float = 0.1
export var JoyStickSensitivity : float = 1.0
export var JoystickDeadzone : float = 0.25
export var CreateInputsForMe : bool = true






# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
