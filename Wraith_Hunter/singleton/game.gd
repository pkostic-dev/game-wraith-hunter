extends Node

var HALLWAY := "res://levels/hallway.tscn"
var KITCHEN := "res://levels/kitchen.tscn"
var MAIN_MENU := "res://menu/main_menu.tscn"
var RECOVER := "res://sequences/recover/recover_sequences.tscn"

var current_level := HALLWAY

# Flags
var tutorial_from_menu := false


func next_level():
	match current_level:
		HALLWAY:
			Global.goto_scene(KITCHEN)
		KITCHEN:
			Global.goto_scene(RECOVER)
