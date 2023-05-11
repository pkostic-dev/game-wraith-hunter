extends Control

## Constructs and manages menus from dictionaries.
##
## Menus are stored in [member menus]. Each menu is an [Array] of [Dictionary] 
## elements describing each menu item. A menu item contains the following key 
## values :
## [br]- string : The text used by the [Label]s.
## [br]- audio : The path to the audio used to describe the menu item.
## [br]- sound : See [enum MenuItemSound].
## [br]- action : A [Dictionary] with the following key values :
## [br]    - type : See [enum MenuActionType].
## [br]    - args : A simple value or an [Array] containing the arguments for 
## the method called by the behavior defined by the [enum MenuActionType].


## Menu items can emit different sounds.
enum MenuItemSound {
	CONFIRM, ## Plays the confirm sound effect on action.
	CANCEL, ## Plays the cancel sound effect on action.
	SLIDER, ## Plays a sound when the slider is moved.
}

## The action that will be executed by interacting with the button. 
enum MenuActionType {
	CHANGE_MENU, ## Changes to a different menu.
	CHANGE_SCENE, ## Changes to another scene.
	CHANGE_LANGUAGE, ## Changes the language of the game.
	CHANGE_DIFFICULTY, ## Changes the difficulty of the game.
	VOLUME_SLIDE, ## Changes the volume of a specific sound.
}

## The opening sequence introduces the player to the game.
const OPENING_SEQUENCE = "res://sequences/opening/opening_sequence.tscn"
## The tutorial sequence teaches the player how to play.
const TUTORIAL_SEQUENCE = "res://sequences/tutorial/tutorial_sequence.tscn"

var main_menu:Array[Dictionary] = [
	{
		"string" : "PLAY",
		"audio" : "res://audio/menu/fr/MENU_STARTGAME.wav",
		"sound" : MenuItemSound.CONFIRM,
		"action" : {
			"type" : MenuActionType.CHANGE_SCENE,
			"args" : OPENING_SEQUENCE,
		}
	},
	{
		"string" : "SETTINGS",
		"audio" : "res://audio/menu/fr/MENU_SETTINGS_Prise2.wav",
		"sound" : MenuItemSound.CONFIRM,
		"action" : {
			"type" : MenuActionType.CHANGE_MENU,
			"args" : "settings",
		},
	},
]

var settings:Array[Dictionary] = [
	{
		"string" : "TUTORIAL",
		"audio" : "res://audio/menu/fr/MENU_RESTART_TUTORIAL.wav",
		"sound" : MenuItemSound.CONFIRM,
		"action" : {
			"type" : MenuActionType.CHANGE_SCENE,
			"args" : TUTORIAL_SEQUENCE,
		}
	},
	{
		"string" : "LANGUAGE",
		"audio" : "res://audio/menu/fr/LANGUAGE_MENU.wav",
		"sound" : MenuItemSound.CONFIRM,
		"action" : {
			"type" : MenuActionType.CHANGE_MENU,
			"args" : "language",
		}
	},
	{
		"string" : "SOUNDS",
		"audio" : "res://audio/menu/fr/MENU_SOUNDS.wav",
		"sound" : MenuItemSound.CONFIRM,
		"action" : {
			"type" : MenuActionType.CHANGE_MENU,
			"args" : "sounds",
		}
	},
	{
		"string" : "DIFFICULTY",
		"audio" : "res://audio/menu/fr/MENU_DIFFICULTY.wav",
		"sound" : MenuItemSound.CONFIRM,
		"action" : {
			"type" : MenuActionType.CHANGE_MENU,
			"args" : "difficulty",
		}
	},
	{
		"string" : "BACK",
		"audio" : "res://audio/menu/fr/BACK_PREVIOUS_MENU.wav",
		"sound" : MenuItemSound.CANCEL,
		"action" : {
			"type" : MenuActionType.CHANGE_MENU,
			"args" : "main_menu",
		},
	}
]

var language:Array[Dictionary] = [
	{
		"string" : "FRENCH",
		"audio" : "res://audio/menu/fr/FRENCH.wav",
		"sound" : MenuItemSound.CONFIRM,
		"action" : {
			"type" : MenuActionType.CHANGE_LANGUAGE,
			"args" : "fr",
		},
	},
	{
		"string" : "ENGLISH",
		"audio" : "res://audio/menu/fr/ENGLISH.wav",
		"sound" : MenuItemSound.CONFIRM,
		"action" : {
			"type" : MenuActionType.CHANGE_LANGUAGE,
			"args" : "en",
		},
	},
	{
		"string" : "BACK",
		"audio" : "res://audio/menu/fr/BACK_PREVIOUS_MENU.wav",
		"sound" : MenuItemSound.CANCEL,
		"action" : {
			"type" : MenuActionType.CHANGE_MENU,
			"args" : "settings",
		},
	},
]

var sounds:Array[Dictionary] = [
	{
		"string" : "ENVIRONMENT",
		"audio" : "res://audio/menu/fr/MENU_SOUNDS_ENVIRONMENT.wav",
		"sound" : MenuItemSound.SLIDER,
		"action" : {
			"type" : MenuActionType.VOLUME_SLIDE,
			"args" : "environment"
		},
	},
	{
		"string" : "VOICE",
		"audio" : "res://audio/menu/fr/MENU_SOUNDS_VOICE.wav",
		"sound" : MenuItemSound.SLIDER,
		"action" : {
			"type" : MenuActionType.VOLUME_SLIDE,
			"args" : "voice"
		},
	},
	{
		"string" : "MUSIC",
		"audio" : "res://audio/menu/fr/MENU_SOUNDS_MUSIC.wav",
		"sound" : MenuItemSound.SLIDER,
		"action" : {
			"type" : MenuActionType.VOLUME_SLIDE,
			"args" : "music"
		},
	},
	{
		"string" : "ENEMIES",
		"audio" : "res://audio/menu/fr/MENU_SOUNDS_GHOST.wav",
		"sound" : MenuItemSound.SLIDER,
		"action" : {
			"type" : MenuActionType.VOLUME_SLIDE,
			"args" : "enemies"
		},
	},
	{
		"string" : "BACK",
		"audio" : "res://audio/menu/fr/BACK_PREVIOUS_MENU.wav",
		"sound" : MenuItemSound.CANCEL,
		"action" : {
			"type" : MenuActionType.CHANGE_MENU,
			"args" : "settings",
		},
	},
]

var difficulty:Array[Dictionary] = [
	{
		"string" : "EASY",
		"audio" : "res://audio/menu/fr/MENU_DIFFICULTY_EASY.wav",
		"sound" : MenuItemSound.CONFIRM,
		"action" : {
			"type" : MenuActionType.CHANGE_DIFFICULTY,
			"args" : "easy",
		},
	},
	{
		"string" : "NORMAL",
		"audio" : "res://audio/menu/fr/MENU_DIFFICULTY_NORMAL.wav",
		"sound" : MenuItemSound.CONFIRM,
		"action" : {
			"type" : MenuActionType.CHANGE_DIFFICULTY,
			"args" : "normal",
		},
	},
	{
		"string" : "HARD",
		"audio" : "res://audio/menu/fr/MENU_DIFFICULTY_HARD.wav",
		"sound" : MenuItemSound.CONFIRM,
		"action" : {
			"type" : MenuActionType.CHANGE_DIFFICULTY,
			"args" : "hard",
		},
	},
	{
		"string" : "BACK",
		"audio" : "res://audio/menu/fr/BACK_PREVIOUS_MENU.wav",
		"sound" : MenuItemSound.CANCEL,
		"action" : {
			"type" : MenuActionType.CHANGE_MENU,
			"args" : "settings",
		},
	},
]

## Dictionary of all the menus.
var menus:Dictionary = {
	"main_menu" : main_menu,
	"settings" : settings, 
	"language" : language, 
	"sounds" : sounds, 
	"difficulty" : difficulty,
}

## The current menu.
var current_menu:Array[Dictionary] = main_menu
## The current selection.
var current_selection:int = 0

## The label representing the currently selected item.
@onready var center_label:Label = %CenterLabel
## The label representing the item on the left of the currently selected item.
@onready var left_label:Label = %LeftLabel
## The label representing the item on the right of the currently selected item.
@onready var right_label:Label = %RightLabel


func _ready():
	_play_audio()
	_set_labels()


## Called when there is an input event.[br]
## Keyboard controls include :[br]
##   - ui_left : calls the _previous function.[br]
##   - ui_right : calls the _next function.[br]
##   - ui_select or ui_accept : interpret the action for the currently selected item.
func _input(event) -> void:
	# Keyboard controls
	if event.is_action_pressed("ui_left"):
		current_selection = _previous(current_menu, current_selection)
		_set_labels()
		$PointerSound.play()
		await $PointerSound.finished
		_play_audio()
	if event.is_action_pressed("ui_right"):
		current_selection = _next(current_menu, current_selection)
		_set_labels()
		$PointerSound.play()
		await $PointerSound.finished
		_play_audio()
	
	if event.is_action_pressed("ui_select") or event.is_action_pressed("ui_accept"):
		var _current_item = current_menu[current_selection]
		
		match _current_item.sound:
			MenuItemSound.CONFIRM:
				$ConfirmSound.play()
			MenuItemSound.CANCEL:
				$CancelSound.play()
		
		match _current_item.action.type:
			MenuActionType.CHANGE_SCENE:
				# Wait for the confirm sound to finish before changing the scene.
				await $ConfirmSound.finished
				Global.goto_scene(_current_item.action.args)
			MenuActionType.CHANGE_MENU:
				current_menu = menus.get(_current_item.action.args)
				current_selection = 0
				_play_audio()
				_set_labels()
			MenuActionType.CHANGE_LANGUAGE:
				Config.config.language = _current_item.action.args
				TranslationServer.set_locale(Config.config.language)
				print_debug("Config.config.language = ", Config.config.language)
				# TODO : play a confirmation audio (e.g. "The language has been changed to [...]")
			MenuActionType.CHANGE_DIFFICULTY:
				Config.config.difficulty = _current_item.action.args
				print_debug("Config.config.difficulty = ", Config.config.difficulty)
			MenuActionType.VOLUME_SLIDE:
				pass


## Returns the next index of an array given an index. If the given index is the
## last index of the array, returns the first index in the array.
func _next(array:Array, index:int) -> int:
	if index < (array.size() - 1):
		return index + 1
	return 0


## Returns the previous index of an array given an index. If the given index is 
## 0, returns the last index in the array.
func _previous(array:Array, index:int) -> int:
	if index > 0:
		return index - 1
	return (array.size() - 1)


## Updates the menu item labels based on the [member current_menu] and 
## [member current_selection].
func _set_labels() -> void:
	center_label.text = current_menu[current_selection].string
	var previous_index := _previous(current_menu, current_selection)
	left_label.text = current_menu[previous_index].string
	var next_index := _next(current_menu, current_selection)
	right_label.text = current_menu[next_index].string
	
	_fit_side_labels()


## Plays the audio associated with the current selection.
func _play_audio() -> void:
	var _current_item = current_menu[current_selection]
	$Audio.stream = load(_current_item.audio)
	$Audio.play()


## Fits the side labels around the central label. Side labels are secondary, 
## thus they are fitted around the CenterLabel based on the free horizontal
## space calculated by windows width minus the width of the central label.
func _fit_side_labels() -> void:
	var window_width:int = DisplayServer.window_get_size().x
	var free_horizontal_space:float = window_width - center_label.size.x
	
	left_label.custom_minimum_size.x = free_horizontal_space / 2.0
	right_label.custom_minimum_size.x = free_horizontal_space / 2.0
