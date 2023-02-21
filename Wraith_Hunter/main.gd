extends Node

var SETUP_SEQUENCE := "res://sequences/setup/setup_sequence.tscn"

func _ready():
	Global.goto_scene(SETUP_SEQUENCE)
