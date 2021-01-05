extends Spatial

export(bool) var vr_enabled = true

var vr_player_prefab = preload("res://player/VRPlayer.tscn")
var fps_player_prefab = preload("res://player/FPSPlayer.tscn")

onready var wrap_field = $"../WrapField"

func _ready():
	if vr_enabled:
		## Setup VR
		create_player(vr_player_prefab)
		var vr = ARVRServer.find_interface("OpenVR")
		if vr and vr.initialize():
			get_viewport().arvr = true
			
			OS.vsync_enabled = false
			Engine.target_fps = 90
	else:
		create_player(fps_player_prefab)
		FPSInput.init()

func create_player(prefab):
	var player : Spatial = prefab.instance()
	var remote_transform = RemoteTransform.new()
	player.add_child(remote_transform)
	remote_transform.remote_path = wrap_field.get_path()
	remote_transform.update_rotation = false
	get_parent().call_deferred("add_child", player)
