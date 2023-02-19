extends Node3D
var focus_button


var EASY = load("res://audio/narration/menu/" + Config.config.language + "/MENU_DIFFICULTY_EASY.wav")
var MEDIUM = load("res://audio/narration/menu/" + Config.config.language + "/MENU_DIFFICULTY_NORMAL.wav")
var HARD = load("res://audio/narration/menu/" + Config.config.language + "/MENU_DIFFICULTY_HARD.wav")
var BACK = load("res://audio/narration/menu/" + Config.config.language + "/MENU_BACK.wav")


func _ready():
	focus_button = %Easy
	focus_button.grab_focus()
	Swipe.swipe_left.connect(_on_swipe_left)
	Swipe.swipe_right.connect(_on_swipe_right)

func _unhandled_input(event):
	var buttons = get_tree().get_nodes_in_group("buttons")
	Swipe.swipe_event(event, $Container, buttons)
	

func _on_swipe_left():
	focus_button = focus_button.find_next_valid_focus()
	focus_button.grab_focus()

func _on_swipe_right():
	focus_button = focus_button.find_prev_valid_focus()
	focus_button.grab_focus()


func _on_easy_pressed():
	pass

func _on_medium_pressed():
	pass # Replace with function body.

func _on_hard_pressed():
	pass # Replace with function body.

func _on_back_pressed():
	Global.goto_scene("res://menu/settings_menu.tscn")

func _on_easy_focus_entered():
	%EasySound.play()
	$AudioStreamPlayer3D.stream = EASY

func _on_medium_focus_entered():
#	%MediumSound.play()
	$AudioStreamPlayer3D.stream = MEDIUM

func _on_hard_focus_entered():
#	%HardSound.play()
	$AudioStreamPlayer3D.stream = HARD

func _on_back_focus_entered():
#	%Back.play()
	$AudioStreamPlayer3D.stream = BACK
