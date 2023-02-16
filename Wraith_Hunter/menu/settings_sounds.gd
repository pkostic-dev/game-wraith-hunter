extends Node3D
var focus_button

func _ready():
	var button_start = %Environment
	%Environment.grab_focus()
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

func _on_environment_pressed():
	pass # Replace with function body.

func _on_voice_pressed():
	pass # Replace with function body.

func _on_music_pressed():
	pass # Replace with function body.

func _on_wraith_pressed():
	pass # Replace with function body.

func _on_back_pressed():
	Global.goto_scene("res://menu/settings_menu.tscn")

func _on_environment_focus_entered():
	%EnvironmentSound.play(0)

func _on_voice_focus_entered():
	%VoiceSound.play(0)

func _on_music_focus_entered():
	%MusicSound.play(0)

func _on_wraith_focus_entered():
	%WraithSound.play(0)

func _on_back_focus_entered():
	%BackToMain.play(0)
