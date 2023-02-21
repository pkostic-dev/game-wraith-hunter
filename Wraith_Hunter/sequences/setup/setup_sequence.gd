extends Node3D

var SETUP_BINAURAL := load("res://audio/setup/" + Config.config.language + "/SETUP_BINAURAL.wav")
var SETUP_CALIBRATION := load("res://audio/setup/" + Config.config.language + "/SETUP_CALIBRATION.wav")
var SETUP_CHAIR := load("res://audio/setup/" + Config.config.language + "/SETUP_CHAIR.wav")
var SETUP_COMPLETE := load("res://audio/setup/" + Config.config.language + "/SETUP_COMPLETE.wav")
var SETUP_LEFT := load("res://audio/setup/" + Config.config.language + "/SETUP_LEFT.wav")
var SETUP_ORIENTATION := load("res://audio/setup/" + Config.config.language + "/SETUP_ORIENTATION.wav")
var SETUP_POSITION := load("res://audio/setup/" + Config.config.language + "/SETUP_POSITION.wav")
var SETUP_RIGHT := load("res://audio/setup/" + Config.config.language + "/SETUP_RIGHT.wav")
var SETUP_SOUND_CHECK := load("res://audio/setup/" + Config.config.language + "/SETUP_SOUND_CHECK.wav")

# SFX
var WRAITH_GROWL := load("res://audio/sound_fx/ghost/creature-growl01.wav")

var MENU_SEQUENCE_SCENE := "res://sequences/menu/menu_sequence.tscn"

# Flags
var binaural_ok := false

var left := Vector3(-20, 0, 0)
var right := Vector3(20, 0, 0)


signal screen_touched

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
	_start_sequence()


func _start_sequence():
	await get_tree().create_timer(3.0).timeout
	_play_sound(SETUP_SOUND_CHECK)
	await $SetupAudio.finished
	
	await get_tree().create_timer(1.0).timeout
	_play_sound(SETUP_CHAIR)
	await $SetupAudio.finished
	
	await get_tree().create_timer(1.0).timeout
	_play_sound(SETUP_CALIBRATION)
	await $SetupAudio.finished
	
	await get_tree().create_timer(1.0).timeout
	_play_sound(SETUP_ORIENTATION)
	await $SetupAudio.finished
	
	# skip SETUP_POSITION, SETUP_LEFT, SETUP_RIGHT
	
	await get_tree().create_timer(1.0).timeout
	_play_sound(SETUP_BINAURAL)
	await $SetupAudio.finished
	
	await get_tree().create_timer(1.0).timeout
	$SetupAudio.position = [left, right].pick_random()
	_play_sound(WRAITH_GROWL)
	# TODO : check if correct side (while loop)
	await self.screen_touched
	
	await get_tree().create_timer(1.0).timeout
	$SetupAudio.position = Vector3(0, 0, 0)
	_play_sound(SETUP_COMPLETE)
	await $SetupAudio.finished
	
	await get_tree().create_timer(1.0).timeout
	Global.goto_scene(MENU_SEQUENCE_SCENE)


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("screen_touched")


func _play_sound(stream):
	if $SetupAudio.playing:
		$SetupAudio.stop()
	$SetupAudio.stream = stream
	$SetupAudio.play()

