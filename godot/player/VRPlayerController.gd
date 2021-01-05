extends Spatial

onready var right_hand = $ARVROrigin/ARVRController2
onready var left_hand = $ARVROrigin/ARVRController
onready var head = $ARVROrigin/ARVRCamera

var velocity = Vector3.ZERO
var angular_velocity = Vector3.ZERO

export(float) var max_speed = 1.0

func add_jetpack_force(hand, delta):
	var hand_thrust : Vector3 = -hand.transform.basis.z * \
	 hand.get_joystick_axis(JOY_VR_ANALOG_TRIGGER)
	velocity += hand_thrust * delta
	if velocity.length_squared() > max_speed * max_speed:
		velocity = velocity.normalized() * max_speed
	transform = transform.translated(velocity * delta)
	
	if hand_thrust.length_squared() > 0.1:
		hand.get_node("Wrist").activate()
	else:
		hand.get_node("Wrist").deactivate()
		
	if hand.is_button_pressed(JOY_VR_PAD):
		hand.get_node("Wrist").fire()

func _process(delta):
	add_jetpack_force(right_hand, delta)
	add_jetpack_force(left_hand, delta)
