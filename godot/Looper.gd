extends Area

const loop_around = -0.80

func on_exit(body):
	
	print(body.name)
	
	var loc = global_transform.origin - body.global_transform.origin
	var new_loc = loc
	
	if abs(loc.x) > 10.0:
		new_loc.x *= loop_around
	if abs(loc.y) > 10.0:
		new_loc.y *= loop_around
	if abs(loc.z) > 10.0:
		new_loc.z *= loop_around
		
	body.global_transform.origin = -new_loc + global_transform.origin
