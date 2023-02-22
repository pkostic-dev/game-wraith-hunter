extends Node3D

var SETUP_BINAURAL
var SETUP_CALIBRATION
var SETUP_CHAIR
var SETUP_COMPLETE
var SETUP_LEFT
var SETUP_ORIENTATION
var SETUP_POSITION
var SETUP_RIGHT
var SETUP_SOUND_CHECK

# SFX
var WRAITH_GROWL := load("res://audio/sound_fx/ghost/creature-growl01.wav")

var MENU_SEQUENCE_SCENE := "res://sequences/menu/menu_sequence.tscn"

# Flags
var binaural_ok := false

var left := Vector3(-20, 0, 0)
var right := Vector3(20, 0, 0)

var chosen_side:Vector3

signal side_chosen

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
	_load_sounds()
	_start_sequence()


func _process(_delta):
	if Input.is_action_just_released("ui_left"):
		chosen_side = left
		side_chosen.emit()
	if Input.is_action_just_released("ui_right"):
		chosen_side = right
		side_chosen.emit()


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
	print($SetupAudio.position)
	_play_sound(WRAITH_GROWL)
	
	while ($SetupAudio.position != chosen_side):
		if not $SetupAudio.playing:
			_play_sound(WRAITH_GROWL)
		await self.side_chosen
	
	await get_tree().create_timer(1.0).timeout
	$SetupAudio.position = Vector3(0, 0, 0)
	_play_sound(SETUP_COMPLETE)
	await $SetupAudio.finished
	
	await get_tree().create_timer(1.0).timeout
	Global.goto_scene(MENU_SEQUENCE_SCENE)


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var window_size := DisplayServer.window_get_size()
		if event.position.x <= window_size.x/2:
			chosen_side = left
			side_chosen.emit()


func _play_sound(stream):
	if $SetupAudio.playing:
		$SetupAudio.stop()
	$SetupAudio.stream = stream
	$SetupAudio.play()


func _load_sounds():
	if OS.has_feature("mobile"):
		SETUP_BINAURAL = load("res://audio/setup/" + Config.config.language + "/SETUP_BINAURAL.wav")
	else:
		SETUP_BINAURAL = load("res://audio/setup/" + Config.config.language + "/SETUP_BINAURAL.wav") # TODO : Replace with PC controls
	SETUP_CALIBRATION = load("res://audio/setup/" + Config.config.language + "/SETUP_CALIBRATION.wav")
	SETUP_CHAIR = load("res://audio/setup/" + Config.config.language + "/SETUP_CHAIR.wav")
	SETUP_COMPLETE = load("res://audio/setup/" + Config.config.language + "/SETUP_COMPLETE.wav")
	SETUP_LEFT = load("res://audio/setup/" + Config.config.language + "/SETUP_LEFT.wav")
	SETUP_ORIENTATION = load("res://audio/setup/" + Config.config.language + "/SETUP_ORIENTATION.wav")
	SETUP_POSITION = load("res://audio/setup/" + Config.config.language + "/SETUP_POSITION.wav")
	SETUP_RIGHT = load("res://audio/setup/" + Config.config.language + "/SETUP_RIGHT.wav")
	SETUP_SOUND_CHECK = load("res://audio/setup/" + Config.config.language + "/SETUP_SOUND_CHECK.wav")
