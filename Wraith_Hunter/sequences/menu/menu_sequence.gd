extends Node3D

var MENU_NAVIGATION_TUTORIAL := load("res://audio/menu/" + Config.config.language + "/MENU_NAVIGATION_TUTORIAL.wav")

var MAIN_MENU_SCENE := "res://menu/main_menu.tscn"
var OPENING_SEQUENCE := "res://sequences/opening_sequence.tscn"


func _ready():
	_start_sequence()


func _start_sequence():
	_play_sound(MENU_NAVIGATION_TUTORIAL)
	await $MenuAudio.finished
	await get_tree().create_timer(1.0).timeout
	Global.goto_scene(OPENING_SEQUENCE)


func _play_sound(stream):
	if $MenuAudio.playing:
		$MenuAudio.stop()
	$MenuAudio.stream = stream
	$MenuAudio.play()
