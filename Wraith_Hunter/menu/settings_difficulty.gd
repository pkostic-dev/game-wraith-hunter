extends Node3D


var focus_button


func _ready():
	var EASY = load("res://audio/menu/" + Config.config.language + "/MENU_DIFFICULTY_EASY.wav")
	var MEDIUM = load("res://audio/menu/" + Config.config.language + "/MENU_DIFFICULTY_NORMAL.wav")
	var HARD = load("res://audio/menu/" + Config.config.language + "/MENU_DIFFICULTY_HARD.wav")
	var BACK = load("res://audio/menu/" + Config.config.language + "/MENU_BACK.wav")
	
	%HardSound.stream = HARD
	%MediumSound.stream = MEDIUM
	%EasySound.stream = EASY
	%Back.stream = BACK

	Swipe.swipe_left.connect(_on_swipe_left)
	Swipe.swipe_right.connect(_on_swipe_right)
	
	focus_button = %Easy
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
	%EasySound.stop()
	%MediumSound.stop()
	%HardSound.stop()
	%Back.stop()


func _on_easy_pressed():
	$MenuSounds.play_confirm()
	await get_tree().create_timer(0.3).timeout
	Config.config.difficulty = "easy"
	Config.save_config()
	Global.goto_scene("res://menu/settings_menu.tscn")


func _on_medium_pressed():
	$MenuSounds.play_confirm()
	await get_tree().create_timer(0.3).timeout
	Config.config.difficulty = "medium"
	Config.save_config()
	Global.goto_scene("res://menu/settings_menu.tscn")


func _on_hard_pressed():
	$MenuSounds.play_confirm()
	await get_tree().create_timer(0.3).timeout
	Config.config.difficulty = "hard"
	Config.save_config()
	Global.goto_scene("res://menu/settings_menu.tscn")


func _on_back_pressed():
	$MenuSounds.play_cancel()
	await get_tree().create_timer(0.3).timeout
	Global.goto_scene("res://menu/settings_menu.tscn")


func _on_easy_focus_entered():
	$MenuSounds.play_pointer()
	await get_tree().create_timer(0.3).timeout
	%EasySound.play()


func _on_medium_focus_entered():
	$MenuSounds.play_pointer()
	await get_tree().create_timer(0.3).timeout
	%MediumSound.play()


func _on_hard_focus_entered():
	$MenuSounds.play_pointer()
	await get_tree().create_timer(0.3).timeout
	%HardSound.play()


func _on_back_focus_entered():
	$MenuSounds.play_pointer()
	await get_tree().create_timer(0.3).timeout
	%Back.play()
