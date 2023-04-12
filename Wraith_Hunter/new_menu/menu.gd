extends Control

enum MenuItemType {CONFIRM, CANCEL, SLIDER}
enum MenuActionType {CHANGE_MENU, CHANGE_SCENE, MAIN_MENU, SETTINGS, CONFIGURE}

const PLAY_SCENE = 0 # TODO : add scene path
const TUTORIAL_SCENE = 0 # TODO : add scene path

# List of all the menus
var menus:Array[Array] = [
	main_menu, 
	settings, 
	language, 
	sounds, 
	difficulty,
]

var main_menu:Array[Dictionary] = [
	{
		"string" : "Play", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.CONFIRM,
		"action" : {
			"type" : MenuActionType.CHANGE_SCENE,
			"args" : [PLAY_SCENE]
		}
	},
	{
		"string" : "Settings", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.CONFIRM,
		"action" : {
			"type" : MenuActionType.CHANGE_MENU,
			"args" : settings,
		},
	},
]

var settings:Array[Dictionary] = [
	{
		"string" : "Tutorial", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.CONFIRM,
		"action" : {
			"type" : MenuActionType.CHANGE_SCENE,
			"args" : TUTORIAL_SCENE,
		}
	},
	{
		"string" : "Language", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.CONFIRM,
		"action" : {
			"type" : MenuActionType.CHANGE_MENU,
			"args" : language,
		}
	},
	{
		"string" : "Sounds", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.CONFIRM,
		"action" : {
			"type" : MenuActionType.CHANGE_MENU,
			"args" : sounds,
		}
	},
	{
		"string" : "Difficulty", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.CONFIRM,
		"action" : {
			"type" : MenuActionType.CHANGE_MENU,
			"args" : difficulty,
		}
	},
	{
		"string" : "Back", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.CANCEL,
		"action" : {
			"type" : MenuActionType.MAIN_MENU,
		},
	}
]

var language:Array[Dictionary] = [
	{
		"string" : "French", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.CONFIRM,
		"action" : {
			"type" : MenuActionType.CONFIGURE,
			"args" : sounds,
		},
	},
	{
		"string" : "English", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.CONFIRM,
		"action" : {
			"type" : MenuActionType.CONFIGURE,
			"args" : difficulty,
		},
	},
	{
		"string" : "Back", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.CANCEL,
		"action" : {
			"type" : MenuActionType.MAIN_MENU,
		},
	},
]

var sounds:Array[Dictionary] = [
	{
		"string" : "Environment", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.SLIDER,
		"action" : {
			"type" : MenuActionType.CONFIGURE,
			"args" : []
		},
	},
	{
		"string" : "Voice", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.SLIDER,
		"action" : {
			"type" : MenuActionType.CONFIGURE,
			"args" : []
		},
	},
	{
		"string" : "Music", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.SLIDER,
		"action" : {
			"type" : MenuActionType.CONFIGURE,
			"args" : []
		},
	},
	{
		"string" : "Enemies", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.SLIDER,
		"action" : {
			"type" : MenuActionType.CONFIGURE,
			"args" : []
		},
	},
	{
		"string" : "Back", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.CANCEL,
		"action" : {
			"type" : MenuActionType.SETTINGS,
		},
	},
]

var difficulty:Array[Dictionary] = [
	{
		"string" : "Easy", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.CONFIRM,
		"action" : {
			"type" : MenuActionType.CONFIGURE,
			"args" : [],
		},
	},
	{
		"string" : "Medium", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.CONFIRM,
		"action" : {
			"type" : MenuActionType.CONFIGURE,
			"args" : [],
		},
	},
	{
		"string" : "Hard", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.CONFIRM,
		"action" : {
			"type" : MenuActionType.CONFIGURE,
			"args" : [],
		},
	},
	{
		"string" : "Back", # TODO : change to function for translation
		"audio" : null, # TODO : add audio
		"type" : MenuItemType.CANCEL,
		"action" : {
			"type" : MenuActionType.MAIN_MENU,
		},
	},
]

var current_menu = settings
var current_selection = 0

@onready var center_label:Label = %CenterLabel
@onready var left_label:Label = %LeftLabel
@onready var right_label:Label = %RightLabel

func _ready():
	_set_labels()

# TODO : play audio, integrate actions (switch?)

func _input(event) -> void:
	# Keyboard controls
	if event.is_action_pressed("ui_left"):
		current_selection = _previous(current_menu, current_selection)
	if event.is_action_pressed("ui_right"):
		current_selection = _next(current_menu, current_selection)
	
	if event.is_action_pressed("ui_select") or event.is_action_pressed("ui_accept"):
		print(current_menu[current_selection].action)
	
	_set_labels()


func _next(array:Array, index:int) -> int:
	if index < (array.size() - 1):
		return index + 1
	return 0


func _previous(array:Array, index:int) -> int:
	if index > 0:
		return index - 1
	return (array.size() - 1)


func _set_labels() -> void:
	center_label.text = current_menu[current_selection].string
	var previous_index := _previous(current_menu, current_selection)
	left_label.text = current_menu[previous_index].string
	var next_index := _next(current_menu, current_selection)
	right_label.text = current_menu[next_index].string
	
	_fit_side_labels()


# Side labels are secondary, thus they are fitted around the CenterLabel
func _fit_side_labels() -> void:
	var window_width:int = DisplayServer.window_get_size().x
	var free_horizontal_space:float = window_width - center_label.size.x
	
	left_label.custom_minimum_size.x = free_horizontal_space / 2.0
	right_label.custom_minimum_size.x = free_horizontal_space / 2.0
