extends Node3D

enum Behavior {
	IDLE,
	SIDE_TO_SIDE,
	ZIG_ZAG,
	HOMING,
	DYING,
}

@export_enum("Idle", "SideToSide", "ZigZag", "Homing") var default_behavior := 3
@export var health := 100.0
@export var strength := 1.0
@export var homing_speed := .5
@export var side_to_side_speed := 10.0
@export var move_during_capture := false
@export var capture_delay := 1.0
@export var capture_speed_multiplier := 0.2
@export_range(0, 30, 0.1, "suffix:s", "or_greater") var repeat_time_min := 7.0
@export_range(0, 30, 0.1, "suffix:s", "or_greater") var repeat_time_max := 9.0

var being_captured := false
var behavior := default_behavior

var player:Node3D
var original_position:Vector3

@onready var growl_sound := $GrowlSound
@onready var hurt_sound := $HurtSound
@onready var attack_sound := $AttackSound
@onready var die_sound := $DieSound
@onready var growl_timer := $GrowlTimer
@onready var capture_timer := $CaptureTimer
@onready var ghost_emoji := $GhostEmoji


func _ready():
	# Play the sound
	#growl_sound.play()
	
	# Start the timer for the first time
	growl_timer.wait_time = randf_range(repeat_time_min, repeat_time_max)
	growl_timer.start()
	
	# Setup capture timer
	capture_timer.wait_time = capture_delay
	
	# Find the player
	var player_name := "Player"
	var player_exists := get_parent().has_node(player_name)
	if player_exists:
		player = get_parent().get_node(player_name)
	
	if is_inside_tree():
		original_position = position


func _process(_delta):
	if (health <= 0) and (not (behavior == Behavior.DYING)):
		die()


func _physics_process(delta):
	match behavior:
		Behavior.IDLE:
			pass
		Behavior.SIDE_TO_SIDE:
			_move_side_to_side(delta)
		Behavior.ZIG_ZAG:
			_move_zig_zag(delta)
		Behavior.HOMING:
			_move_home_in(delta)
		Behavior.DYING:
			pass


func capture(capture_rate):
	if not being_captured:
		being_captured = true
		health -= capture_rate
		if not move_during_capture:
			behavior = Behavior.IDLE
		capture_timer.start()


func die():
	die_sound.play() # TODO : Change this sound
	behavior = Behavior.DYING


func _move_home_in(delta):
	if player:
		var player_direction = (player.position - position).normalized()
		var _homing_speed = homing_speed
		if being_captured:
			_homing_speed *= capture_speed_multiplier
		global_translate(homing_speed * player_direction * delta)


# TODO : Update for _physics_process
func _move_side_to_side(delta):
#	var _tween := get_tree().create_tween()
#	var _left = -10
#	var _right = 10
#	var _duration = 5
#	var _loops = 100
#
#	_tween.tween_property(self, "position", Vector3(_right, position.y, position.z), _duration)
#	_tween.tween_property(self, "position", Vector3(_left, position.y, position.z), _duration)
#
#	_tween.set_loops(_loops)
	pass


func _move_zig_zag(delta):
	pass


func _on_growl_sound_finished():
	# DEBUG : Reset the color to white
	ghost_emoji.modulate = Color(1, 1, 1)


func _on_collision_area_body_entered(body):
	print(body)


func _on_capture_timer_timeout():
	being_captured = false


func _on_die_sound_finished():
	queue_free()


func _on_growl_timer_timeout():
	if not growl_sound.playing:
		# Play the sound
		growl_sound.play()
		# DEBUG : Change the GhostEmoji text color to green
		ghost_emoji.modulate = Color(.2, 1, .2)
	
	# Repeat the timer
	growl_timer.wait_time = randf_range(repeat_time_min, repeat_time_max)
	growl_timer.start()