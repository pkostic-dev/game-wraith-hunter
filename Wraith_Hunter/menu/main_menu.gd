extends Node3D

var swipe_start = null
var minimum_drag = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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
			
func _right():
	$Container.position.x -= 1150

func _left():
	$Container.position.x = 1150


func _on_settings_pressed():
	Global.goto_scene("res://menu/settings_menu.tscn")

func _on_start_game_pressed():
	pass # Replace with function body.


func _on_start_game_focus_entered():
	#$AudioStreamPlayer.play()
	pass


func _on_settings_focus_entered():
	pass # Replace with function body.


