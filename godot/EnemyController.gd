extends Spatial

const speed_map = {1:10.0, 2:5.0, 3:1.0}
const scale_map = {1:0.1, 2:0.5, 3:1.0}

func _ready():
	for i in range(10):
		create_asteroid()
	
func rand_in_box():
	return rand_range(-10.0, 10.0)
	
func on_asteroid_hit(asteroid, laser):
	if asteroid.size != 1:
		for i in range(3):
			var new_asteroid = AsteroidPool.pop()
			add_child(new_asteroid)
			new_asteroid.size = asteroid.size - 1
			new_asteroid.transform.origin = asteroid.transform.origin
			new_asteroid.apply_central_impulse(Vector3(randf()-0.5,randf()-0.5,randf()-0.5).normalized() * speed_map[new_asteroid.size])
			new_asteroid.global_scale(Vector3.ONE * scale_map[new_asteroid.size])
		
	laser.queue_free()
	asteroid.queue_free()

func create_asteroid():
	var location = Vector3(rand_in_box(), rand_in_box(), rand_in_box())
	
	## Flip a six sided coin
	match randi() % 6:
		0:
			location.x = -10.0
		1:
			location.x = 10.0
		2:
			location.y = -10.0
		3:
			location.y = 10.0
		4:
			location.z = -10.0
		5:
			location.z = 10.0
			
	var velocity = Vector3(randf() - 0.5, randf() - 0.5, randf() - 0.5).normalized()
	
	var my_asteroid : RigidBody = AsteroidPool.pop()
	add_child(my_asteroid)
	my_asteroid.translate(location)
	my_asteroid.apply_central_impulse(velocity)
	
