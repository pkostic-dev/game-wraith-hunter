extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	Swipe.swipe_event(event, $Container)


func _on_french_pressed():
	pass # Replace with function body.


func _on_french_focus_entered():
	pass # Replace with function body.


func _on_english_pressed():
	pass # Replace with function body.


func _on_english_focus_entered():
	pass # Replace with function body.


func _on_back_pressed():
	Global.goto_scene("res://menu/settings_menu.tscn")


func _on_back_focus_entered():
	pass # Replace with function body.
