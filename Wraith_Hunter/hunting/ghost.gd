extends Node3D

enum Behavior {
	IDLE,
	SIDE_TO_SIDE,
	ZIG_ZAG,
	HOMING,
}

@export_enum("Idle", "SideToSide", "ZigZag", "Homing") var behavior := 3
@export var health := 100.0
@export var strength := 1.0
@export var homing_speed := .5
@export var side_to_side_speed := 10.0
@export var move_during_capture := false
@export var capture_speed_multiplier := 0.2
@export_range(0, 30, 0.1, "suffix:s", "or_greater") var repeat_time_min := 7.0
@export_range(0, 30, 0.1, "suffix:s", "or_greater") var repeat_time_max := 9.0

var player:Node3D
var original_position:Vector3

@onready var growl_sound := $GrowlSound
@onready var sound_timer := $SoundTimer
@onready var ghost_emoji := $GhostEmoji


func _ready():
	# Play the sound
	#growl_sound.play()
	
	# Start the timer for the first time
	sound_timer.wait_time = randf_range(repeat_time_min, repeat_time_max)
	sound_timer.start()
	
	# Find the player
	var player_name := "Player"
	var player_exists := get_parent().has_node(player_name)
	if player_exists:
		player = get_parent().get_node(player_name)
	
	if is_inside_tree():
		original_position = position


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


func _move_home_in(delta):
	if player:
		var player_direction = (player.position - position).normalized()
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


func _on_sound_timer_timeout():
	if not growl_sound.playing:
		# Play the sound
		growl_sound.play()
		# DEBUG : Change the GhostEmoji text color to green
		ghost_emoji.modulate = Color(.2, 1, .2)
	
	# Repeat the timer
	sound_timer.wait_time = randf_range(repeat_time_min, repeat_time_max)
	sound_timer.start()


func _on_growl_sound_finished():
	# DEBUG : Reset the color to white
	ghost_emoji.modulate = Color(1, 1, 1)


func _on_collision_area_body_entered(body):
	print(body)
