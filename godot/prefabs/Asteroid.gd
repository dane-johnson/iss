extends Spatial

var size = 3

var velocity = Vector3.ZERO

onready var enemy_controller = $".."

func _process(delta):
	transform.origin += velocity * delta

func laser_hit(body):
	enemy_controller.on_asteroid_hit(self, body)
