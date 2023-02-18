extends Node3D
var focus_button

func _ready():
	focus_button = %French
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

func _on_french_pressed():
	pass # Replace with function body.

func _on_english_pressed():
	pass # Replace with function body.

func _on_back_pressed():
	Global.goto_scene("res://menu/settings_menu.tscn")

func _on_french_focus_entered():
	%FrenchSound.play()

func _on_english_focus_entered():
	%EnglishSound.play()

func _on_back_focus_entered():
	%BackToMain.play()
