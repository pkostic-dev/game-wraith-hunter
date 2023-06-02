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
@export var homing_speed := .2
@export var side_to_side_speed := 10.0
@export var move_during_capture := false
@export var capture_speed_multiplier := 0.2
@export_range(0, 30, 0.1, "suffix:s", "or_greater") var repeat_time_min := 1.0
@export_range(0, 30, 0.1, "suffix:s", "or_greater") var repeat_time_max := 2.0

var capture_delay := 0.1
var being_captured := false
var dying := false
var behavior := default_behavior

var growl_fade_out_tween:Tween
var hurt_fade_out_tween:Tween
var player:Node3D
var original_position:Vector3

var growl_sound_1 := preload("res://audio/sound_fx/ghost/creature-growl01.wav")
var growl_sound_2 := preload("res://audio/sound_fx/ghost/creature-growl02.wav")
var growl_sound_3 := preload("res://audio/sound_fx/ghost/creature-growl03.wav")

var growl_sounds := [growl_sound_1, growl_sound_2, growl_sound_3]


@onready var growl_timer := $GrowlTimer
@onready var ghost_emoji := $GhostEmoji


signal died


func _ready():
	# Play the sound if easy difficulty
#	if Config.config.difficulty == Config.Difficulty.EASY:
#		$GrowlSound.play()
	
	# Start the timer for the first time
	growl_timer.wait_time = randf_range(repeat_time_min, repeat_time_max)
	growl_timer.start()
	
	# Find the player
	var player_name := "Player"
	var player_exists := get_parent().has_node(player_name)
	if player_exists:
		player = get_parent().get_node(player_name)
	
	if is_inside_tree():
		original_position = position


func _process(_delta):
	if (health <= 0.0) and not dying:
		die()
	
	if dying:
		$GhostEmoji.modulate = Color.RED
		$GhostEmoji.modulate.a = 0.5
	
	if not being_captured:
		if not dying:
			$GhostEmoji.modulate = Color.WHITE
		if $HurtSound.playing:
			hurt_fade_out_tween = get_tree().create_tween()
			hurt_fade_out_tween.tween_property($HurtSound, "volume_db", -100, 4)
	
	if $GrowlSound.playing and $GrowlSound.volume_db <= -100.0:
		$GrowlSound.stop()


func _physics_process(delta):
	if dying:
		position.y -= 0.01
	match behavior:
		Behavior.IDLE:
			pass
		Behavior.SIDE_TO_SIDE:
			_move_side_to_side(delta)
		Behavior.ZIG_ZAG:
			_move_zig_zag(delta)
		Behavior.HOMING:
			_move_home_in(delta)
		_:
			pass


func capture(capture_rate):
	if not being_captured:
		being_captured = true
		health -= capture_rate
		print("health =", health)
		
		$GhostEmoji.modulate = Color.YELLOW
		
		# Behavior
		if not move_during_capture:
			behavior = Behavior.IDLE
		
		# Hurt sound
		if hurt_fade_out_tween != null:
			if hurt_fade_out_tween.is_running():
				hurt_fade_out_tween.stop()
		$HurtSound.volume_db = 0.0
		$HurtSound.play()
		
		$CaptureDelayTimer.start(capture_delay)


func die():
	print("dying")
	$DieSound.play()
	dying = true
	$CollisionArea/CollisionShape3D.disabled = true
	emit_signal("died")


func _move_home_in(delta):
	if player:
		var player_direction = (player.position - position).normalized()
		var _homing_speed = homing_speed
		if being_captured:
			_homing_speed *= capture_speed_multiplier
		global_translate(homing_speed * player_direction * delta)


# TODO : Update for _physics_process
func _move_side_to_side(_delta):
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


func _move_zig_zag(_delta):
	pass


func _on_growl_sound_finished():
	# DEBUG : Reset the color to white
	#ghost_emoji.modulate = Color.WHITE
	pass


func _on_collision_area_body_entered(body):
	print(body)


func _on_die_sound_finished():
	queue_free()


func _on_growl_timer_timeout():
	if not $GrowlSound.playing:
		# Play the sound
		$GrowlSound.volume_db = 0.0
		$GrowlSound.stream = growl_sounds.pick_random()
		$GrowlSound.play()
		growl_fade_out_tween = get_tree().create_tween()
		growl_fade_out_tween.tween_property($GrowlSound, "volume_db", -100, $GrowlSound.stream.get_length()/2)
		
		# DEBUG : Change the GhostEmoji text color to green
		#ghost_emoji.modulate = Color.GREEN
	
	# Repeat the timer
	growl_timer.wait_time = randf_range(repeat_time_min, repeat_time_max)
	growl_timer.start()


func _on_capture_delay_timer_timeout():
	being_captured = false
	if not dying: 
		behavior = default_behavior


func _reset_position():
	$CollisionArea.monitorable = true
	position = original_position


func _on_collision_area_area_entered(_area):
	$AttackSound.play()
	$CollisionArea.set_deferred("monitorable", false)
	await $AttackSound.finished
	_reset_position()
