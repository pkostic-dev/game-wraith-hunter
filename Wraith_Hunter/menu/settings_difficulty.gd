extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _unhandled_input(event):
	Swipe.swipe_event(event, $Container)


func _on_easy_pressed():
	pass

func _on_medium_pressed():
	pass # Replace with function body.

func _on_hard_pressed():
	pass # Replace with function body.


func _on_back_pressed():
	Global.goto_scene("res://menu/settings_menu.tscn")

func _on_easy_focus_entered():
	%EasySound.play(0)

func _on_medium_focus_entered():
	%MediumSound.play(0)

func _on_hard_focus_entered():
	%HardSound.play(0)

func _on_back_focus_entered():
	%Back.play(0)
