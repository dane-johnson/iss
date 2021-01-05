extends Spatial

const asteroid_prefab = preload("res://prefabs/Asteroid.tscn")

const speed_map = {1:10.0, 2:5.0, 3:1.0}
const scale_map = {1:0.1, 2:0.5, 3:1.0}

var asteroids = []
onready var player_manager = $"../PlayerManager";

func _ready():
	for _i in range(3):
		create_asteroid(3, random_face())
	
func _process(_delta):
	if not player_manager.player:
		return
		
	for asteroid in asteroids:
		Looper.loop(asteroid, player_manager.player.global_transform.origin)
		
func rand_in_box():
	return rand_range(-10.0, 10.0)
	
func random_face():
	var location = Vector3(rand_in_box(), rand_in_box(), rand_in_box())
	
	## Roll 1d6
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
	return location
	
func on_asteroid_hit(asteroid, laser):
	if asteroid.size != 1:
		for i in range(3):
			call_deferred("create_asteroid", asteroid.size - 1, asteroid.global_transform.origin)
	laser.queue_free()
	asteroids.erase(asteroid)
	asteroid.queue_free()

func create_asteroid(size, location):
	var velocity = Vector3(randf()-0.5,randf()-0.5,randf()-0.5).normalized() * speed_map[size]
	
	var my_asteroid = asteroid_prefab.instance()
	my_asteroid.size = size
	add_child(my_asteroid)
	my_asteroid.translate(location)
	my_asteroid.velocity = velocity
	asteroids.append(my_asteroid)
	
	for loc in Looper.phantom_loc():
		var phantom_mesh = my_asteroid.get_node("MeshInstance").duplicate()
		my_asteroid.add_child(phantom_mesh)
		phantom_mesh.global_transform.origin = location + loc
		var phantom_area = my_asteroid.get_node("Area").duplicate()
		my_asteroid.add_child(phantom_area)
		phantom_area.global_transform.origin = location + loc
