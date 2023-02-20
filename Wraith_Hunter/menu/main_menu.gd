extends Node3D
var focus_button

func _ready():
	
	var STARTGAME = load("res://audio/menu/" + Config.config.language + "/MENU_STARTGAME.wav")
	var ACCESS_SETTINGS = load("res://audio/menu/" + Config.config.language + "/MENU_SETTINGS_Prise2.wav")
	
	%SettingsSound.stream = ACCESS_SETTINGS
	%StartGameSound.stream = STARTGAME
	
	Swipe.swipe_left.connect(_on_swipe_left)
	Swipe.swipe_right.connect(_on_swipe_right)

	focus_button = %StartGame
	focus_button.grab_focus()
	print("premier focus")
	print(focus_button)
	
func _input(event):
	print(event.as_text())
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

func _on_settings_pressed():
		print("chargement scene settings_menu")
		Global.goto_scene("res://menu/settings_menu.tscn")

func _on_start_game_pressed():
	pass # Replace with function body.

func _on_start_game_focus_entered():
	%StartGameSound.play()
	

func _on_settings_focus_entered():
	%SettingsSound.play()
