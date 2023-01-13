extends Node3D


func _ready():
	pass


func _process(delta):	
	var acc = Input.get_accelerometer()
	var mag = Input.get_magnetometer()
	
	var gravity   = Input.get_gravity()
	var gyroscope = Input.get_gyroscope()

	$DebugInterface/VBoxContainer/Acc.text = "Accelometer : " + str(acc) 
	$DebugInterface/VBoxContainer/Grav.text = "Gravity : " + str(gravity)
	$DebugInterface/VBoxContainer/Mag.text = "Magnetometer : " + str(mag)
	$DebugInterface/VBoxContainer/Gyro.text = "Gyroscope : " + str(gyroscope)
	
	var camera = $TestPlayer/Camera3D
	var new_basis = rotate_by_gyro(gyroscope, camera.transform.basis, delta).orthonormalized()
	print("Gyroscope :\t\t\t", str(gyroscope))
	print("Gravity :\t\t\t", str(gravity))

	print("Camera Basis :\t\t", str(camera.transform.basis))
	print("New Basis :\t\t\t", str(new_basis))

	camera.transform.basis = drift_correction(new_basis, gravity)
	print("Drift Correction :\t", str(camera.transform.basis))
	print()


# This function takes our gyro input and update an orientation matrix accordingly
# The gyro is special as this vector does not contain a direction but rather a
# rotational velocity. This is why we multiply our values with delta.
func rotate_by_gyro(p_gyro, p_basis, p_delta):
	var _rotate = Basis()
	
	_rotate = _rotate.rotated(p_basis.x, -p_gyro.x * p_delta)
	_rotate = _rotate.rotated(p_basis.y, -p_gyro.y * p_delta)
	_rotate = _rotate.rotated(p_basis.z, -p_gyro.z * p_delta)
	
	return _rotate * p_basis


# This function corrects the drift in our matrix by our gravity vector 
func drift_correction(p_basis, p_grav):
	# as always, make sure our vector is normalized but also invert as our gravity points down
	var real_up = -p_grav.normalized()
	
	# start by calculating the dot product, this gives us the cosine angle between our two vectors
	var dot = p_basis.y.dot(real_up)
	
	# if our dot is 1.0 we're good
	if (dot < 1.0):
		# the cross between our two vectors gives us a vector perpendicular to our two vectors
		var axis = p_basis.y.cross(real_up).normalized()
		if axis == Vector3.ZERO:
			return p_basis
		var correction = Basis(axis, acos(dot))
		p_basis = correction * p_basis
	
	return p_basis

