extends Node3D

var capture_rate := 50.0

var gravity:Vector3
var gyroscope:Vector3

@onready var head := $Head
@onready var raycast := $Head/RayCast3D
@onready var raycast_debug := $Head/RayCast3D/RayCastDebug

func _process(delta):
	gravity   = Input.get_gravity()
	gyroscope = Input.get_gyroscope()
	
	var new_basis = rotate_by_gyro(gyroscope, head.transform.basis, delta).orthonormalized()

	head.transform.basis = new_basis
	
	# DEBUG : Simulate gyroscope for debugging on PC
	if Input.is_action_pressed("ui_left"):
		head.transform.basis = rotate_by_gyro(Vector3(0, 1, 0), head.transform.basis, delta).orthonormalized()
	
	if Input.is_action_pressed("ui_right"):
		head.transform.basis = rotate_by_gyro(Vector3(0, -1, 0), head.transform.basis, delta).orthonormalized()
	
	# DEBUG : Simulate screen touch for debugging on PC
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_capture()


func _physics_process(_delta):
	# DEBUG : Change RayCastDebug color based on whether RayCast3D is colliding
	if raycast.is_colliding():
		raycast_debug.mesh.material.albedo_color = Color.WHITE
	else:
		raycast_debug.mesh.material.albedo_color = Color.YELLOW_GREEN


func _unhandled_input(event):
	if event is InputEventScreenTouch:
		_capture()


func _capture():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider:
			var ghost = collider.get_parent()
			ghost.capture(capture_rate)
			# TODO : Play capture sound (sound fade out if no longer touching)


func rotate_by_gyro(p_gyro, p_basis, p_delta) -> Basis:
	var _rotate = Basis()

	_rotate = _rotate.rotated(p_basis.y, p_gyro.y * p_delta) # yaw
	
	return _rotate * p_basis
