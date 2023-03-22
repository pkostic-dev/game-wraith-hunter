extends Node3D


var OPENING_HANDLER
var OPENING_REAPER
var OPENING_WRAITHS

var TUTORIAL_SEQUENCE := "res://sequences/tutorial/tutorial_sequence.tscn"

func _ready():
	_load_sounds()
	Global.first_playthrough = false
	_start_sequence()


func _start_sequence():
	await get_tree().create_timer(2.0).timeout
	
	
	_play_sound(OPENING_HANDLER)
	await $OpeningAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	_play_sound(OPENING_REAPER)
	await $OpeningAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	_play_sound(OPENING_WRAITHS)
	await $OpeningAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	# TODO Play door opening sound
	Global.goto_scene(TUTORIAL_SEQUENCE)
	#Global.goto_scene(Game.current_level)


func _play_sound(stream):
	if $OpeningAudio.playing:
		$OpeningAudio.stop()
	$OpeningAudio.stream = stream
	$OpeningAudio.play()


func _load_sounds():
	OPENING_HANDLER = load("res://audio/setup/" + Config.config.language + "/OPENING_HANDLER.wav")
	OPENING_REAPER = load("res://audio/setup/" + Config.config.language + "/OPENING_REAPER.wav")
	OPENING_WRAITHS = load("res://audio/setup/" + Config.config.language + "/OPENING_WRAITHS.wav")
