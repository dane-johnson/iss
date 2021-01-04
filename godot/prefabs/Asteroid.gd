extends RigidBody

var size = 3

onready var mesh_instance = $MeshInstance
#onready var collision_shape = $CollisionShape
onready var laser_area = $Area
onready var enemy_controller = $".."

func _ready():
	for x in range (-2, 3):
		for y in range(-2, 3):
			for z in range(-2, 3):
				if x == 0 and y == 0 and z == 0:
					continue
				var my_mesh = mesh_instance.duplicate(Node.DUPLICATE_USE_INSTANCING)
				#var my_collision = collision_shape.duplicate(Node.DUPLICATE_USE_INSTANCING)
				var my_laser_area = laser_area.duplicate(Node.DUPLICATE_SIGNALS | Node.DUPLICATE_USE_INSTANCING)
				var location = transform.origin
				location.x += 20.0 * x
				location.y += 20.0 * y
				location.z += 20.0 * z
				my_mesh.transform.origin = location
				#my_collision.transform.origin = location
				my_laser_area.transform.origin = location
				add_child(my_mesh)
				#add_child(my_collision)
				add_child(my_laser_area)

func laser_hit(body):
	enemy_controller.on_asteroid_hit(self, body)
