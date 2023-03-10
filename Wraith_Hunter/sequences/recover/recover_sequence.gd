extends Node3D


var RECOVER_FAINT := load("res://audio/game/" + Config.config.language + "/RECOVER_FAINT.wav")
var FALL := load("res://audio/sound_fx/player/fall.wav")

var CURRENT_LEVEL := Game.current_level


func _ready():
	_start_sequence()


func _start_sequence():
	_play_sound(FALL)
	await $RecoverAudio.finished
	await get_tree().create_timer(3.0).timeout
	
	
	
	_play_sound(RECOVER_FAINT)
	await $RecoverAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	# TODO Open door sound ?
	
	Global.goto_scene(CURRENT_LEVEL)


func _play_sound(stream):
	if $RecoverAudio.playing:
		$RecoverAudio.stop()
	$RecoverAudio.stream = stream
	$RecoverAudio.play()
