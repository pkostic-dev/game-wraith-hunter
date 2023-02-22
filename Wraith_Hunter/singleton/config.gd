extends Node

const CONFIG_FILE_PATH := "user://config.json"

var config:Dictionary

var default_config:Dictionary = {
	"difficulty" : "normal",
	"master_volume" : 100,
	"music_volume" : 50,
	"language" : "fr",
	# TODO : Add other settings here
}

var keys := ["difficulty", "master_volume", "music_volume", "language"]

enum Difficulty {EASY, MEDIUM, HARD}

func _ready():
	var config_file := load_file(CONFIG_FILE_PATH)
	if config_file == null:
		create_default_config()
	else:
		if config.has_all(keys):
			load_config()
		else:
			create_default_config()
	print(config)


func create_default_config():
	print("create_default_config")
	config = default_config
	save_config()


func save_config():
	print("save_config")
	var data := JSON.stringify(config)
	save_file(data, CONFIG_FILE_PATH)


func load_config():
	print("load_config")
	var loaded_file := load_file(CONFIG_FILE_PATH)
	var parsed_file = JSON.parse_string(loaded_file.get_as_text())
	
	if typeof(parsed_file) == TYPE_DICTIONARY:
		print("is dict")
		config = parsed_file
	else:
		printerr("Error while loading the configuration file.")


func load_file(file_path:String) -> FileAccess:
	print("load_file")
	if not FileAccess.file_exists(file_path):
		print("no file")
		return null
	var opened_file := FileAccess.open(file_path, FileAccess.READ)
	return opened_file


func save_file(content:Variant, file_path:String):
	var file := FileAccess.open(file_path, FileAccess.WRITE)
	match typeof(content):
		TYPE_STRING:
			file.store_string(content)
		_:
			file.store_var(content)

