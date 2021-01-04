extends Node

var asteroid_pool: Array
var curr = 0

var asteroid_prefab = preload("res://prefabs/Asteroid.tscn")

func _ready():
	allocate()

func allocate():
	for i in range(90):
		asteroid_pool.append(asteroid_prefab.instance())
		
func pop():
	var asteroid = asteroid_pool[curr]
	curr += 1
	return asteroid
