extends Spatial

var velocity = Vector3.ZERO
var look = Vector3(0.0, 0.0, 0.0);

onready var wrist = $Wrist

export(float) var max_speed = 2.0

func _process(delta):
	## Turn
	look.x = clamp(look.x + FPSInput.pitch, -PI/2, PI/2)
	look.y = look.y + FPSInput.yaw
	## Reset rotation
	transform.basis = Basis()
	rotate_x(look.x)
	rotate_y(look.y)
	
	## Translate
	velocity += Quat(transform.basis).xform(FPSInput.move_vec * delta)
	if velocity.length_squared() > max_speed * max_speed:
		velocity = velocity.normalized() * max_speed
	transform.origin = transform.origin + velocity * delta
	
	if FPSInput.fire:
		wrist.fire()
	
	## All done, zero out axes
	FPSInput.reset_axes()
