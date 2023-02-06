extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	Swipe.swipe_event(event, $Container)


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
	pass # Replace with function body.


func _on_voice_focus_entered():
	pass # Replace with function body.


func _on_music_focus_entered():
	pass # Replace with function body.


func _on_wraith_focus_entered():
	pass # Replace with function body.


func _on_back_focus_entered():
	pass # Replace with function body.
