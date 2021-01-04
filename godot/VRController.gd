extends Spatial

export(bool) var debug_view = true

func _ready():
	if debug_view:
		pass
	else:
		var vr = ARVRServer.find_interface("OpenVR")
		if vr and vr.initialize():
			get_viewport().arvr = true
			
			OS.vsync_enabled = false
			Engine.target_fps = 90
