extends Node3D


#func _unhandled_input(event):
	#print("unhandled input")
	
#	if(event == InputEventScreenDrag):
	#Swipe.swipe_event(event, $Container)

func _unhandled_input(event):
	print(event.as_text())
	Swipe.swipe_event(event, $Container)
	#if event is InputEventScreenDrag:
	#	print("screen drag")
	#	Swipe.swipe_event(event, $Container)
	#if event is InputEventScreenTouch : 
	#	print("screen touch")


func _on_settings_pressed():
	print("bouton appuyé :")
	print(InputEvent)
	Global.goto_scene("res://menu/settings_menu.tscn")

func _on_start_game_pressed():
	pass # Replace with function body.

func _on_start_game_focus_entered():
	%StartGameSound.play(0)

func _on_settings_focus_entered():
	%SettingsSound.play(0)


