extends Node3D
var focus_button


func _ready():
	
	var TUTORIAL = load("res://audio/menu/" + Config.config.language + "/MENU_RESTART_TUTORIAL.wav")
	var DIFFICULTY = load("res://audio/menu/" + Config.config.language + "/MENU_DIFFICULTY.wav")
	var SOUNDS = load("res://audio/menu/" + Config.config.language + "/MENU_SOUNDS.wav")
	var LANGUAGE = load("res://audio/menu/" + Config.config.language + "/MENU_LANGUAGE.wav")
	var BACK = load("res://audio/menu/" + Config.config.language + "/MENU_BACK.wav")

	%TutorialRedo.stream = TUTORIAL
	%DifficultySettings.stream = DIFFICULTY
	%SoundsSettings.stream = SOUNDS
	%LanguageSettings.stream = LANGUAGE
	%BackToMain.stream = BACK

	Swipe.swipe_left.connect(_on_swipe_left)
	Swipe.swipe_right.connect(_on_swipe_right)
	
	focus_button = %Tutorial
	focus_button.grab_focus()
	print("premier focus")
	print(focus_button)

func _input(event):
	var buttons = get_tree().get_nodes_in_group("buttons")
	Swipe.swipe_event(event, $Container, buttons)

func _on_swipe_left():
	Swipe.move_scene_left()
	stop_all_sounds()
	print("start swipe left button")
	print(focus_button)
	focus_button = focus_button.find_next_valid_focus()
	focus_button.grab_focus()
	print("end swipe left focus")
	print(focus_button)

func _on_swipe_right():
	Swipe.move_scene_right()
	stop_all_sounds()
	print("start swipe right button")
	print(focus_button)
	focus_button = focus_button.find_prev_valid_focus()
	focus_button.grab_focus()
	print("end swipe right focus")
	print(focus_button)
	
func stop_all_sounds():
	%TutorialRedo.stop()
	%DifficultySettings.stop()
	%SoundsSettings.stop()
	%LanguageSettings.stop()
	%BackToMain.stop()
	
func _on_tutorial_pressed():
	Game.tutorial_from_menu = true
	Global.goto_scene("res://sequences/tutorial/tutorial_sequence.tscn")

func _on_difficulty_pressed():
	Global.goto_scene("res://menu/settings_difficulty.tscn")

func _on_sounds_pressed():
	Global.goto_scene("res://menu/settings_sounds.tscn")

func _on_language_pressed():
	Global.goto_scene("res://menu/settings_language.tscn")

func _on_back_pressed():
	Global.goto_scene("res://menu/main_menu.tscn")

func _on_tutorial_focus_entered():
	%TutorialRedo.play() 

func _on_difficulty_focus_entered():
	%DifficultySettings.play()

func _on_sounds_focus_entered():
	%SoundsSettings.play()

func _on_language_focus_entered():
	%LanguageSettings.play()

func _on_back_focus_entered():
	%BackToMain.play()
	
