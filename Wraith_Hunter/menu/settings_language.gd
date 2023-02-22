extends Node3D
var focus_button

func _ready():
	
	var FRENCH = load("res://audio/menu/" + Config.config.language + "/MENU_LANGUAGE_FRENCH.wav")
	var ENGLISH = load("res://audio/menu/" + Config.config.language + "/MENU_LANGUAGE_ENGLISH.wav")
	var BACK = load("res://audio/menu/" + Config.config.language + "/MENU_BACK.wav")

	%BackToMain.stream = BACK
	%EnglishSound.stream = ENGLISH
	%FrenchSound.stream = FRENCH


	Swipe.swipe_left.connect(_on_swipe_left)
	Swipe.swipe_right.connect(_on_swipe_right)
	
	focus_button = %French
	focus_button.grab_focus()

func _input(event):
	var buttons = get_tree().get_nodes_in_group("buttons")
	Swipe.swipe_event(event, $Container, buttons)
	
func _on_swipe_left():
	Swipe.move_scene_left()
	stop_all_sounds()
	focus_button = focus_button.find_next_valid_focus()
	focus_button.grab_focus()

func _on_swipe_right():
	Swipe.move_scene_right()
	stop_all_sounds()
	focus_button = focus_button.find_prev_valid_focus()
	focus_button.grab_focus()
	
func stop_all_sounds():
	%FrenchSound.stop()
	%EnglishSound.stop()
	%BackToMain.stop()


func _on_french_pressed():
	$MenuSounds.play_confirm()
	await get_tree().create_timer(0.3).timeout
	Config.config.language = "fr"
	Global.goto_scene("res://menu/settings_menu.tscn")

func _on_english_pressed():
	$MenuSounds.play_confirm()
	await get_tree().create_timer(0.3).timeout
	Config.config.language = "en"
	Global.goto_scene("res://menu/settings_menu.tscn")

func _on_back_pressed():
	$MenuSounds.play_cancel()
	await get_tree().create_timer(0.3).timeout
	Global.goto_scene("res://menu/settings_menu.tscn")

func _on_french_focus_entered():
	$MenuSounds.play_pointer()
	await get_tree().create_timer(0.3).timeout
	%FrenchSound.play()

func _on_english_focus_entered():
	$MenuSounds.play_pointer()
	await get_tree().create_timer(0.3).timeout
	%EnglishSound.play()
	
func _on_back_focus_entered():
	$MenuSounds.play_pointer()
	await get_tree().create_timer(0.3).timeout
	%BackToMain.play()
