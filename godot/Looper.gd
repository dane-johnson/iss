extends Node

class_name Looper

const box_extent = 10.0
const asteroid_radius = 1.0


static func loop(node : Spatial, offset : Vector3):
	var loc = node.global_transform.origin - offset
	var new_loc = loc
	
	for axis in range(3):
		if abs(loc[axis]) > box_extent + asteroid_radius:
			new_loc[axis] = (box_extent - asteroid_radius) * sign(loc[axis]) * -1.0

	node.global_transform.origin = offset + new_loc
	
static func phantom_loc():
	var locs = []
	for x in range(-2,3):
		for y in range(-2,3):
			for z in range(-2,3):
				if x == 0 and y == 0 and z == 0:
					continue
				locs.append(Vector3(x * box_extent * 2, y * box_extent * 2, z * box_extent * 2))
	return locs
