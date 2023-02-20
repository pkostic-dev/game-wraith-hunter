extends Node3D

var SETUP_BINAURAL = load("res://audio/setup/" + Config.config.language + "/SETUP_BINAURAL.wav")
var SETUP_CALIBRATION = load("res://audio/setup/" + Config.config.language + "/SETUP_CALIBRATION.wav")
var SETUP_CHAIR = load("res://audio/setup/" + Config.config.language + "/SETUP_CHAIR.wav")
var SETUP_COMPLETE = load("res://audio/setup/" + Config.config.language + "/SETUP_COMPLETE.wav")
var SETUP_LEFT = load("res://audio/setup/" + Config.config.language + "/SETUP_LEFT.wav")
var SETUP_ORIENTATION = load("res://audio/setup/" + Config.config.language + "/SETUP_ORIENTATION.wav")
var SETUP_POSITION = load("res://audio/setup/" + Config.config.language + "/SETUP_POSITION.wav")
var SETUP_RIGHT = load("res://audio/setup/" + Config.config.language + "/SETUP_RIGHT.wav")
var SETUP_SOUND_CHECK = load("res://audio/setup/" + Config.config.language + "/SETUP_SOUND_CHECK.wav")

# SFX
var WRAITH_GROWL = load("res://audio/sound_fx/ghost/creature-growl01.wav")

# Flags
var left_touched := false
var right_touched := false
var different_sides := false
var binaural_ok := false

# Invert sides
var left:Vector2
var right:Vector2
var left_is_right := false

var stream_list := [SETUP_SOUND_CHECK, SETUP_CHAIR, SETUP_CALIBRATION, SETUP_ORIENTATION, SETUP_POSITION, SETUP_LEFT, SETUP_RIGHT, SETUP_BINAURAL, WRAITH_GROWL, SETUP_COMPLETE]
var next := 0
var is_pausing := true

# Sequence
# 1. Play SETUP_SOUND_CHECK
# 2. Play SETUP_CHAIR
# 3. Play SETUP_CALIBRATION
# 4. Play SETUP_ORIENTATION
# 5. Play SETUP_POSITION
# 5bis. Get smartphone position
# 6. Play SETUP_LEFT
# 6bis. Wait for touch, check side
# 7. Play SETUP_RIGHT
# 7bis. Wait for touch, check side
# If same side, repeat from 6.
# If different side, save left/right positions
# 8. Play SETUP_BINAURAL
# 8bis. Play a ghost sound on the left or right
# If correctly guessed, continue
# Else repeat until correct
# 9. Play SETUP_COMPLETE

func _ready():
	# Initial pause
	# Wait 4 seconds at the beginning
	# More than 7 sec = problem
	_pause(4)


func _process(_delta):
	if (not $SetupAudio.playing) and (not is_pausing):
		match stream_list[next]:
			SETUP_BINAURAL:
				# Wait for touch on the right side
				if right_touched and different_sides:
					_pause(1)
					_play_sound(stream_list[next])
			SETUP_RIGHT:
				# Wait for touch on the left side
				if left_touched:
					_pause(1)
					_play_sound(stream_list[next])
			SETUP_POSITION:
				# Wait for touch for position setup
				# Game currently doesn't support different positions so skip
				next += 1
			_:
				_pause(2)
				_play_sound(stream_list[next])


func _play_sound(stream):
	if $SetupAudio.playing:
		$SetupAudio.stop()
	$SetupAudio.stream = stream
	$SetupAudio.play()


func _pause(seconds):
	is_pausing = true
	$PauseTimer.start(seconds)


func _on_setup_audio_finished():
	next += 1


func _on_pause_timer_timeout():
	is_pausing = false
