extends Node3D
var focus_button

var TUTORIAL = load("res://audio/narration/menu/" + Config.config.language + "/MENU_RESTART_TUTORIAL.wav")
var DIFFICULTY = load("res://audio/narration/menu/" + Config.config.language + "/MENU_DIFFICULTY.wav")
var SOUNDS = load("res://audio/narration/menu/" + Config.config.language + "/MENU_SOUNDS.wav")
var LANGUAGE = load("res://audio/narration/menu/" + Config.config.language + "/MENU_LANGUAGE.wav")
var BACK = load("res://audio/narration/menu/" + Config.config.language + "/MENU_BACK.wav")


func _ready():
	focus_button = %Tutorial
	focus_button.grab_focus()
	print("premier focus")
	print(focus_button)
	Swipe.swipe_left.connect(_on_swipe_left)
	Swipe.swipe_right.connect(_on_swipe_right)

func _unhandled_input(event):
	var buttons = get_tree().get_nodes_in_group("buttons")
	Swipe.swipe_event(event, $Container, buttons)

func _on_swipe_left():
	print("start swipe left button")
	print(focus_button)
	focus_button = focus_button.find_next_valid_focus()
	focus_button.grab_focus()
	print("end swipe left focus")
	print(focus_button)

func _on_swipe_right():
	print("start swipe right button")
	print(focus_button)
	focus_button = focus_button.find_prev_valid_focus()
	focus_button.grab_focus()
	print("end swipe right focus")
	print(focus_button)

func _on_tutorial_pressed():
	pass # Replace with function body.

func _on_difficulty_pressed():
	Global.goto_scene("res://menu/settings_difficulty.tscn")

func _on_sounds_pressed():
	Global.goto_scene("res://menu/settings_sounds.tscn")

func _on_language_pressed():
	Global.goto_scene("res://menu/settings_language.tscn")

func _on_back_pressed():
	Global.goto_scene("res://menu/main_menu.tscn")

func _on_tutorial_focus_entered():
#	%TutorialRedo.play() 
	$AudioStreamPlayer3D.stream = TUTORIAL

func _on_difficulty_focus_entered():
#	%DifficultySettings.play()
	$AudioStreamPlayer3D.stream = DIFFICULTY

func _on_sounds_focus_entered():
#	%SoundsSettings.play()
	$AudioStreamPlayer3D.stream = SOUNDS

func _on_language_focus_entered():
#	%LanguageSettings.play()
	$AudioStreamPlayer3D.stream = LANGUAGE

func _on_back_focus_entered():
#	%BackToMain.play()
	$AudioStreamPlayer3D.stream = BACK

