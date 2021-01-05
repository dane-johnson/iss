extends Node

## Interface between the raw input class and the FPS-mode scripts
var pitch = 0.0
var yaw = 0.0

var move_vec = Vector3.ZERO

const mouse_sensitivity = 30.0

func init():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func reset_axes():
	pitch = 0.0
	yaw = 0.0
	move_vec = Vector3.ZERO

func _input(event):
	## Gamepad Input
	if event is InputEventJoypadMotion:
		match event.axis:
			JOY_ANALOG_LX:
				yaw = event.axis_value
			JOY_ANALOG_LY:
				pitch = event.axis_value
	## Mouse and Keyboard Input
	## Pitch and Yaw
	if event is InputEventMouseMotion:
		yaw = -min(event.relative.x, mouse_sensitivity) / mouse_sensitivity
		pitch = -min(event.relative.y, mouse_sensitivity) / mouse_sensitivity
	## Movement Vector
	if event is InputEventKey:
		match event.scancode:
			KEY_W:
				move_vec.z += -1.0
			KEY_S:
				move_vec.z += 1.0
