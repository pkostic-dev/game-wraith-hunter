extends Node3D
var focus_button

func _ready():
	var button_start = %Easy
	%Easy.grab_focus()
	focus_button = button_start
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
	%EasySound.play(0)

func _on_medium_focus_entered():
	%MediumSound.play(0)

func _on_hard_focus_entered():
	%HardSound.play(0)

func _on_back_focus_entered():
	%Back.play(0)
