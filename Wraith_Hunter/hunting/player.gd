extends Node3D

var gravity:Vector3
var gyroscope:Vector3

@onready var head := $Head

func _process(delta):
	gravity   = Input.get_gravity()
	gyroscope = Input.get_gyroscope()
	
	var new_basis = rotate_by_gyro(gyroscope, head.transform.basis, delta).orthonormalized()

	head.transform.basis = new_basis


func rotate_by_gyro(p_gyro, p_basis, p_delta):
	var _rotate = Basis()

	#_rotate = _rotate.rotated(p_basis.x, 0)#p_gyro.x * p_delta) # pitch ?
	_rotate = _rotate.rotated(p_basis.y, p_gyro.y * p_delta) # yaw
	#_rotate = _rotate.rotated(p_basis.z, 0)#p_gyro.z * p_delta) # roll
	
	return _rotate * p_basis
