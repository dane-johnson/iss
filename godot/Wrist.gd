extends Spatial

onready var loops = $Particles

var laser_prefab = preload("res://prefabs/Laser.tscn")

var armed = true

func activate():
	if not loops.emitting:
		loops.emitting = true
	
func deactivate():
	if loops.emitting:
		loops.emitting = false

func fire():
	if not armed:
		return
	armed = false
	var laser = laser_prefab.instance()
	get_tree().get_root().add_child(laser)
	laser.global_transform.basis = global_transform.basis.orthonormalized()
	laser.global_transform.origin = global_transform.origin
	laser.apply_central_impulse(laser.transform.basis.z * 10)
	$ReloadTimer.start()
	
func reload():
	armed = true
