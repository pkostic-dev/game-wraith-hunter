extends Node3D
var focus_button

func _ready():
	
	var EASY = load("res://audio/menu/" + Config.config.language + "/MENU_DIFFICULTY_EASY.wav")
	var MEDIUM = load("res://audio/menu/" + Config.config.language + "/MENU_DIFFICULTY_NORMAL.wav")
	var HARD = load("res://audio/menu/" + Config.config.language + "/MENU_DIFFICULTY_HARD.wav")
	var BACK = load("res://audio/menu/" + Config.config.language + "/MENU_BACK.wav")
	
	%Back.stream = BACK
	%HardSound.stream = HARD
	%MediumSound.stream = MEDIUM
	%EasySound.stream = EASY


	Swipe.swipe_left.connect(_on_swipe_left)
	Swipe.swipe_right.connect(_on_swipe_right)
	
	focus_button = %Easy
	focus_button.grab_focus()

func _input(event):
	var buttons = get_tree().get_nodes_in_group("buttons")
	Swipe.swipe_event(event, $Container, buttons)
	

func _on_swipe_left():
	Swipe.move_scene_left()
	focus_button = focus_button.find_next_valid_focus()
	focus_button.grab_focus()

func _on_swipe_right():
	Swipe.move_scene_right()
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
	
func _on_medium_focus_entered():
	%MediumSound.play()
	
func _on_hard_focus_entered():
	%HardSound.play()

func _on_back_focus_entered():
	%Back.play()
