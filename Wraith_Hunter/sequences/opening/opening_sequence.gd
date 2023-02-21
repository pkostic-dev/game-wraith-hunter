extends Node3D


var OPENING_HANDLER := load("res://audio/setup/" + Config.config.language + "/OPENING_HANDLER.wav")
var OPENING_REAPER := load("res://audio/setup/" + Config.config.language + "/OPENING_REAPER.wav")
var OPENING_WRAITHS := load("res://audio/setup/" + Config.config.language + "/OPENING_WRAITHS.wav")

var HALLWAY := "res://levels/hallway.tscn"


func _ready():
	Global.first_playthrough = false
	_start_sequence()


func _start_sequence():
	_play_sound(OPENING_HANDLER)
	await $OpeningAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	_play_sound(OPENING_REAPER)
	await $OpeningAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	_play_sound(OPENING_WRAITHS)
	await $OpeningAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	# Play door opening sound
	
	Global.goto_scene(HALLWAY)


func _play_sound(stream):
	if $OpeningAudio.playing:
		$OpeningAudio.stop()
	$OpeningAudio.stream = stream
	$OpeningAudio.play()
