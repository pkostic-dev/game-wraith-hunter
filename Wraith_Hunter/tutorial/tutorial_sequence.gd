extends Node3D

var TUTORIAL_AIM = load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_AIM.wav")
var TUTORIAL_CAPTURE_END = load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_CAPTURE_END.wav")
var TUTORIAL_CAPTURE_READY = load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_CAPTURE_READY.wav")
var TUTORIAL_CAPTURE_START = load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_CAPTURE_START.wav")
var TUTORIAL_LOW_HEALTH = load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_LOW_HEALTH.wav")
var TUTORIAL_PAUSE = load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_PAUSE.wav")
var TUTORIAL_WRAITH = load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_WRAITH.wav")
var TUTORIAL_WRAITH_ATTACK_1 = load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_WRAITH_ATTACK_1.wav")
var TUTORIAL_WRAITH_ATTACK_2 = load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_WRAITH_ATTACK_2.wav")
var TUTORIAL_WRAITH_MOVE = load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_WRAITH_MOVE.wav")

# SFX
var WRAITH_GROWL
var WRAITH_ATTACK
var LOW_HEALTH

# Flags
var aim_success := false
var screen_touched := false
var ghost_dead := false

var stream_list := [WRAITH_GROWL, TUTORIAL_WRAITH, TUTORIAL_AIM, TUTORIAL_CAPTURE_READY, TUTORIAL_CAPTURE_START, TUTORIAL_CAPTURE_END, TUTORIAL_WRAITH_ATTACK_1, TUTORIAL_WRAITH_ATTACK_2, TUTORIAL_LOW_HEALTH, TUTORIAL_WRAITH_MOVE, TUTORIAL_PAUSE]
var next := 0
var is_pausing := true

# Sequence
# 1. Play WRAITH_GROWL
# 2. Play TUTORIAL_WRAITH
# 3. Play TUTORIAL_AIM
# 4. Wait for aim_success == true
# 5. Play TUTORIAL_CAPTURE_READY
# 6. Play TUTORIAL_CAPTURE_START
# 7. Wait for screen_touched == true
# 8. Wait for ghost_dead == true
# 9. Play TUTORIAL_CAPTURE_END
# 10. Play TUTORIAL_WRAITH_ATTACK_1
# 11. Play WRAITH_ATTACK, TUTORIAL_WRAITH_ATTACK_2
# 12. Play TUTORIAL_LOW_HEALTH, low health sfx, low health vibration
# 13. Play TUTORIAL_WRAITH_MOVE
# 14. Play TUTORIAL_PAUSE

func _ready():
	# Initial pause
	# Wait 4 seconds at the beginning
	# More than 7 sec = problem
	$PauseTimer.start(4)


func _process(_delta):
	if not $TutorialAudio.playing and not is_pausing:
		_play_sound(stream_list[0])
	pass


func _play_sound(stream):
	if $TutorialAudio.playing:
		$TutorialAudio.stop()
	$TutorialAudio.stream = stream
	$TutorialAudio.play()


func _on_audio_stream_player_3d_finished():
	next += 1

