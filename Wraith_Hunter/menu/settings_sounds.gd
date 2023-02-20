extends Node3D
var focus_button


func _ready():

	var ENVIRONMENT = load("res://audio/menu/" + Config.config.language + "/MENU_SOUNDS_ENVIRONMENT.wav")
	var VOICE = load("res://audio/menu/" + Config.config.language + "/MENU_SOUNDS_VOICE.wav")
	var MUSIC = load("res://audio/menu/" + Config.config.language + "/MENU_SOUNDS_MUSIC.wav")
	var WRAITH = load("res://audio/menu/" + Config.config.language + "/MENU_SOUNDS_GHOST.wav")
	var BACK = load("res://audio/menu/" + Config.config.language + "/MENU_BACK.wav")

	%BackToMain.stream = BACK
	%WraithSound.stream = WRAITH
	%MusicSound.stream = MUSIC
	%VoiceSound.stream = VOICE
	%EnvironmentSound.stream = ENVIRONMENT

	Swipe.swipe_left.connect(_on_swipe_left)
	Swipe.swipe_right.connect(_on_swipe_right)
	
	focus_button = %Environment
	focus_button.grab_focus()

func _input(event):
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
	%EnvironmentSound.play()

func _on_voice_focus_entered():
	%VoiceSound.play()


func _on_music_focus_entered():
	%MusicSound.play()
	
func _on_wraith_focus_entered():
	%WraithSound.play()
	
func _on_back_focus_entered():
	%BackToMain.play()
	
