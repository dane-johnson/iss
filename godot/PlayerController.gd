extends Spatial

onready var right_hand = $ARVROrigin/ARVRController2
onready var left_hand = $ARVROrigin/ARVRController
onready var head = $ARVROrigin/ARVRCamera

var velocity = Vector3.ZERO
var angular_velocity = Vector3.ZERO

export(float) var max_speed = 1.0

const loop_around = -1.0

func add_jetpack_force(hand, delta):
	var hand_thrust : Vector3 = -hand.transform.basis.z * \
	 hand.get_joystick_axis(JOY_VR_ANALOG_TRIGGER)
	velocity += hand_thrust * delta
	if velocity.length_squared() > max_speed * max_speed:
		velocity = velocity.normalized() * max_speed
	transform = transform.translated(velocity * delta)
#
#	## Loop around
#	var loc = transform.origin
#	var new_loc = loc
#	if abs(loc.x) > 10.0:
#		new_loc.x *= loop_around
#	if abs(loc.y) > 10.0:
#		new_loc.y *= loop_around
#	if abs(loc.z) > 10.0:
#		new_loc.z *= loop_around
#	transform.origin = new_loc
#
#	var lever_arm : Vector3 = hand.transform.origin - (head.transform.origin - Vector3(0.0, 0.5, 0.0))
#	var torque : Vector3 = lever_arm.cross(hand_thrust)
#	angular_velocity += torque * delta
#	angular_velocity = angular_velocity.normalized() * \
#	 clamp(angular_velocity.length(), -0.628, 0.628)
#	rotate_x(angular_velocity.x * delta)
#	rotate_y(angular_velocity.y * delta)
#	rotate_z(angular_velocity.z * delta)
	
	if hand_thrust.length_squared() > 0.1:
		hand.get_node("Wrist").activate()
	else:
		hand.get_node("Wrist").deactivate()
		
	if hand.is_button_pressed(JOY_VR_PAD):
		hand.get_node("Wrist").fire()

func _process(delta):
	add_jetpack_force(right_hand, delta)
	add_jetpack_force(left_hand, delta)
