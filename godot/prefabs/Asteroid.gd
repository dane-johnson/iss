extends Spatial

var size = 3

var velocity = Vector3.ZERO

onready var enemy_controller = $".."

func _ready():
	var noise = OpenSimplexNoise.new()
	noise.period = 18
	noise.seed = randi()
	$MeshInstance.get_surface_material(0).normal_texture.noise = noise
	

func _process(delta):
	transform.origin += velocity * delta

func laser_hit(body):
	enemy_controller.on_asteroid_hit(self, body)
