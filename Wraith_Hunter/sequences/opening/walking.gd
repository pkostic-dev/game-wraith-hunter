extends AudioStreamPlayer3D



func _process(delta):
	var homing_speed = 0.1
	var direction = Vector3(0, 0, 0)
	global_translate(homing_speed * direction * delta)
	print(position)
