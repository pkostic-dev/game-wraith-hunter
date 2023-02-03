extends Node3D

var swipe_start = null
var minimum_drag = 100
var screen_size = 1150

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Swipe 
func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			swipe_start = event.get_position()
		else:
			_calculate_swipe(event.get_position())
	
func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		return
	var swipe = swipe_end - swipe_start
	if abs(swipe.x) > minimum_drag:
		if swipe.x > 0:
			_right()
		else:
			_left()

# When swipe right (from left to right)
func _right():
	$Container.position.x -= screen_size
	
#When swipe left (from right to left)
func _left():
	if $Container.position.x == 0:
		$Container.position.x -= (screen_size*4)
	else: 
		$Container.position.x += screen_size
		
		
func _on_tutorial_pressed():
	pass # Replace with function body.


func _on_difficulty_pressed():
	pass # Replace with function body.


func _on_sounds_pressed():
	pass # Replace with function body.


func _on_language_pressed():
	pass # Replace with function body.

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


