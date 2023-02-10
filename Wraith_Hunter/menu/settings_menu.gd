extends Node3D


func _unhandled_input(event):
	var buttons = get_tree().get_nodes_in_group("buttons")
	Swipe.swipe_event(event, $Container, buttons)

func _on_tutorial_pressed():
	pass # Replace with function body.


func _on_difficulty_pressed():
	Global.goto_scene("res://menu/settings_difficulty.tscn")


func _on_sounds_pressed():
	Global.goto_scene("res://menu/settings_sounds.tscn")


func _on_language_pressed():
	Global.goto_scene("res://menu/settings_language.tscn")

func _on_back_pressed():
	Global.goto_scene("res://menu/main_menu.tscn")


# Menu audio
func _on_back_focus_entered():
	%TutorialRedo.play(0)

func _on_difficulty_focus_entered():
	%DifficultySettings.play(0)

func _on_sounds_focus_entered():
	%SoundsSettings.play(0)

func _on_language_focus_entered():
	%BackToMain.play(0)


func _on_tutorial_focus_entered():
	pass # Replace with function body.


