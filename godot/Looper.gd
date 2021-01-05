extends Node

class_name Looper

const box_extent = 10.0
const asteroid_radius = 1.0

static func loop(node : Spatial, offset : Vector3):
	
	print(node.name)
	
	var loc = node.global_transform.origin - offset
	var new_loc = loc
	
	for axis in range(3):
		if abs(loc[axis]) > box_extent + asteroid_radius:
			new_loc[axis] = (box_extent - asteroid_radius) * sign(loc[axis]) * -1.0

	node.global_transform.origin = offset + new_loc
