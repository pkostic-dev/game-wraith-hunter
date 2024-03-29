extends Node3D

var RECOVER_SEQUENCE := "res://sequences/recover/recover_sequence.tscn"

var vibrated := false
var can_aim := true
var can_capture := true
var is_capturing := false
var new_touch := true
var capture_rate := 3.0
var health := 100.0

var fade_out_tween:Tween

var gravity:Vector3
var gyroscope:Vector3

var capturing_original_db:float

@onready var head := $Head
@onready var raycast := $Head/RayCast3D
@onready var raycast_debug := $Head/RayCast3D/RayCastDebug

signal wraith_locked_on


func _ready():
	capturing_original_db = $CapturingSound.volume_db


func _process(delta):	
	gravity   = Input.get_gravity()
	gyroscope = Input.get_gyroscope()
	
	var new_basis = rotate_by_gyro(gyroscope, head.transform.basis, delta).orthonormalized()
	
	if can_aim:
		head.transform.basis = new_basis
	
		# PC controls
		if Input.is_action_pressed("ui_left"):
			head.transform.basis = rotate_by_gyro(Vector3.UP, head.transform.basis, delta).orthonormalized()
		
		if Input.is_action_pressed("ui_right"):
			head.transform.basis = rotate_by_gyro(Vector3.DOWN, head.transform.basis, delta).orthonormalized()
	
	# DEBUG : Simulate screen touch for debugging on PC
#	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
#		_capture()

	if Input.is_action_just_pressed("ui_select") and can_capture:
		is_capturing = true
		new_touch = true

	if Input.is_action_just_released("ui_select"):
		is_capturing = false
		if $CapturingSound.playing:
			fade_out_tween = get_tree().create_tween().set_parallel(true)
			fade_out_tween.tween_property($CapturingSound, "volume_db", -100.0, 3)
			fade_out_tween.tween_property($CapturingSound, "pitch_scale", 0.1, 3)

	if is_capturing:
		_capture()
	
	if health <= 50.0 and not $BreathingSound.playing:
		$BreathingSound.volume_db = -health
		$BreathingSound.play()
	
	if health <= 0.0:
		Global.goto_scene(RECOVER_SEQUENCE)


func _physics_process(_delta):
	# DEBUG : Change RayCastDebug color based on whether RayCast3D is colliding
	if raycast.is_colliding():
		raycast_debug.mesh.material.albedo_color = Color.WHITE
		emit_signal("wraith_locked_on")
		if not vibrated:
			vibrated = true
			if OS.has_feature("mobile"):
				Input.vibrate_handheld(400)
			else:
				$VibrateSound.play()
	else:
		vibrated = false
		raycast_debug.mesh.material.albedo_color = Color.YELLOW_GREEN


func _unhandled_input(event):
	# Mobile touch/mouse controls
	if event is InputEventMouseButton:
		if event.pressed and can_capture:
			is_capturing = true
			new_touch = true
		if not event.pressed:
			is_capturing = false
			if $CapturingSound.playing:
				fade_out_tween = get_tree().create_tween().set_parallel(true)
				fade_out_tween.tween_property($CapturingSound, "volume_db", -100.0, 3)
				fade_out_tween.tween_property($CapturingSound, "pitch_scale", 0.1, 3)


func _capture():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider:
			var ghost = collider.get_parent()
			ghost.capture(capture_rate)
			_stop_capturing_fade_out()
			$CapturingSound.volume_db = capturing_original_db
			$CapturingSound.pitch_scale = 1.0
			if not $CapturingSound.playing:
				$CapturingSound.play()
	else:
		if $CapturingSound.playing:
			$CapturingSound.stop()
		if (not $MissSound.playing or $MissSound.get_playback_position() >= 0.5) and new_touch:
			$MissSound.play()
			new_touch = false


func _stop_capturing_fade_out():
	if fade_out_tween != null:
		if fade_out_tween.is_running():
			fade_out_tween.stop()
			$CapturingSound.stop()


func rotate_by_gyro(p_gyro, p_basis, p_delta) -> Basis:
	var _rotate = Basis()

	_rotate = _rotate.rotated(p_basis.y, p_gyro.y * p_delta) # yaw
	
	return _rotate * p_basis


func _hurt():
	health -= 10.0


func _on_area_3d_area_entered(_area):
	_hurt()
