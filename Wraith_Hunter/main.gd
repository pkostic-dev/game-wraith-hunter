extends Node

var TEST_LEVEL := "res://tests/test_level.tscn"
var TUTORIAL_SEQUENCE := "res://tutorial/tutorial_sequence.tscn"
var SETUP_SEQUENCE := "res://setup/setup_sequence.tscn"

func _ready():
	Global.goto_scene(SETUP_SEQUENCE)
