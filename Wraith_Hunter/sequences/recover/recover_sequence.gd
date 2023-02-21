extends Node3D


var RECOVER_FAINT := load("res://audio/game/" + Config.config.language + "/RECOVER_FAINT.wav")

var CURRENT_LEVEL := Game.current_level


func _ready():
	_start_sequence()


func _start_sequence():
	# TODO faint sound (drop down on the ground) ?
	
	_play_sound(RECOVER_FAINT)
	await $OpeningAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	# TODO Open door sound ?
	
	Global.goto_scene(CURRENT_LEVEL)


func _play_sound(stream):
	if $OpeningAudio.playing:
		$OpeningAudio.stop()
	$OpeningAudio.stream = stream
	$OpeningAudio.play()
