extends Node

## Configuration singleton.
##
## Contains methods related to storing, saving, and loading configuration data.

## Dictionary containing the current configuration.
var config:Dictionary

## All the keys that the configuration file must contain. Must contain all the 
## keys of the [member default_config] [Dictionary]. They keys are stored as [String]s.
var keys:Array[String] = ["difficulty", "master_volume", "music_volume", "language"]

## Path to the configuration file.
const CONFIG_FILE_PATH := "user://config.json"

## Default configuration dictionary. Must contain all the keys listed in the 
## [member keys] [Array].
const DEFAULT_CONFIG:Dictionary = {
	"difficulty" : "normal",
	"master_volume" : 100,
	"music_volume" : 50,
	"language" : "fr",
}

## The different difficulty levels of the game. Not the same as level complexity.
enum Difficulty {
	EASY, ## Slightly easier.
	NORMAL, ## The way it is meant to be played.
	HARD ## Slightly harder.
}


## Checks whether the config file exists and whether it is correct with 
## [method check_config].
## Changes the language with [method change_language].
func _ready():
	check_config()
	change_language(config.language)


## Checks whether the config file exists with [method load_file], and whether 
## it contain all the keys from [member keys]. If it fails these checks, a new 
## config file is created using [method create_default_config].
func check_config() -> void:
	var config_file := load_file(CONFIG_FILE_PATH)
	if config_file == null:
		create_default_config()
	else:
		if config.has_all(keys):
			load_config()
		else:
			create_default_config()


## Changes the locale of the game given a [String].
func change_language(locale:String) -> void:
	TranslationServer.set_locale(locale)


## Creates and saves a config file based on [member DEFAULT_CONFIG].
func create_default_config():
	config = DEFAULT_CONFIG
	save_config()


## Saves the config data by stringifying [member config] and saving the result 
## as a file to [member CONFIG_FILE_PATH]
func save_config():
	var data := JSON.stringify(config)
	save_file(data, CONFIG_FILE_PATH)


## Loads the config file located at [member CONFIG_FILE_PATH].
## The file is parsed to JSON and stored into [member config] as a [Dictionary].
func load_config():
	var loaded_file := load_file(CONFIG_FILE_PATH)
	var parsed_file = JSON.parse_string(loaded_file.get_as_text())
	
	if typeof(parsed_file) == TYPE_DICTIONARY:
		config = parsed_file
	else:
		printerr("Error : not a Dictionary.")


## Loads a file given a path.
## If the file doesn't exist at file path, returns [code]null[/code].
## Else returns a [FileAccess] object.
func load_file(file_path:String) -> FileAccess:
	if not FileAccess.file_exists(file_path):
		print_debug("File at location ", file_path, " does not exist.")
		return null
	var opened_file := FileAccess.open(file_path, FileAccess.READ)
	return opened_file


## Saves data to a file given a file path.
## If data is a [String], it is saved as such.
## Else it is saved as a [Variant] value.
func save_file(data:Variant, file_path:String):
	var file := FileAccess.open(file_path, FileAccess.WRITE)
	match typeof(data):
		TYPE_STRING:
			file.store_string(data)
		_:
			file.store_var(data)

