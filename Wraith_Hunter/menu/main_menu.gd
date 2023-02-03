extends Node3D

func _on_settings_pressed():
	Global.goto_scene("res://menu/settings_menu.tscn")

func _on_start_game_pressed():
	pass # Replace with function body.

func _on_start_game_focus_entered():
	%StartGameSound.play(0)

func _on_settings_focus_entered():
	%SettingsSound.play(0)


