extends Node3D


var focus_button
var buttons

var TUTORIAL_SEQUENCE := "res://sequences/tutorial/tutorial_sequence.tscn"
var OPENING_SEQUENCE := "res://sequences/opening/opening_sequence.tscn"
var screen_width = DisplayServer.window_get_size().x
var screen_height = DisplayServer.window_get_size().y

func _ready():
	
	
	%Container.get_child(0).custom_minimum_size().x = screen_width
	%Container.get_child(0).custom_minimum_size().y = screen_height
	%Container.get_child(1).custom_minimum_size().x = screen_width
	%Container.get_child(1).custom_minimum_size().y = screen_height
	
		
	var STARTGAME = load("res://audio/menu/" + Config.config.language + "/MENU_STARTGAME.wav")
	var ACCESS_SETTINGS = load("res://audio/menu/" + Config.config.language + "/MENU_SETTINGS_Prise2.wav")
	
	%SettingsSound.stream = ACCESS_SETTINGS
	%StartGameSound.stream = STARTGAME
	
	Swipe.swipe_left.connect(_on_swipe_left)
	Swipe.swipe_right.connect(_on_swipe_right)

	Swipe.swipe_up.connect(_on_swipe_up)
	Swipe.swipe_down.connect(_on_swipe_down)

	focus_button = %StartGame
	focus_button.grab_focus()
	print("premier focus")
	print(focus_button)


func _input(event):
	#print(event.as_text())
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

func _on_swipe_up():
	print("swipe up signal")
	
func _on_swipe_down():
	print("swipe down signal")

func stop_all_sounds():
	%StartGameSound.stop()
	%SettingsSound.stop()


func _on_start_game_pressed():
	if Global.first_playthrough:
		Global.goto_scene(TUTORIAL_SEQUENCE)
	else:
		Global.goto_scene(OPENING_SEQUENCE)

func _on_settings_pressed():
	print("chargement scene settings_menu")
	Global.goto_scene("res://menu/settings_menu.tscn")


func _on_start_game_focus_entered():
	%StartGameSound.play()


func _on_settings_focus_entered():
	%SettingsSound.play()
