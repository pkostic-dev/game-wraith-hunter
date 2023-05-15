extends Node

## Old swipe singleton (disabled).


var swipe_start = null
var screen_width = DisplayServer.window_get_size().x
var screen_height = DisplayServer.window_get_size().y
# /3 commented out to remove annoying error.
var minimum_drag_left_right = screen_width#/3
var minimum_drag_up_down = screen_height#/3

var current_scene 
var buttons_group
signal swipe_right
signal swipe_left
signal swipe_up
signal swipe_down
var x_min
var x_max = 0
var nb_buttons


func swipe_event(event, container, buttons):
	current_scene = container
	buttons_group = buttons
	nb_buttons = buttons_group.size()-1
	x_min = -screen_width * nb_buttons
	if event is InputEventScreenTouch:
		if event.pressed:
			swipe_start = event.get_position()
		else:
			_calculate_swipe(event.get_position())


func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		return
	var swipe = swipe_end - swipe_start
	if abs(swipe.x) > minimum_drag_left_right:
		for button in buttons_group:
			button.disabled = true
		if swipe.x > 0:
			_right()
		else:
			_left()
	if abs(swipe.y) > minimum_drag_up_down and abs(swipe.x) < minimum_drag_left_right :
		for button in buttons_group:
			button.disabled = true
		if swipe.y < 0:
			_up()
		else: 
			_down()


func _right():
	print("swipe right")
	swipe_right.emit()


func _left():
	print("swipe left")
	swipe_left.emit()


func _up():
	print("swipe up")
	swipe_up.emit()
	for button in buttons_group:
		button.disabled = false


func _down():
	print("swipe down")
	swipe_down.emit()
	for button in buttons_group:
		button.disabled = false


func move_scene_right():
	if current_scene.position.x >= x_max:
		current_scene.position.x -= screen_width * nb_buttons
	else:
		current_scene.position.x += screen_width
	for button in buttons_group:
		button.disabled = false


func move_scene_left():
	if current_scene.position.x <= x_min:
		current_scene.position.x = 0
	else:
		current_scene.position.x -= screen_width
	for button in buttons_group:
		button.disabled = false
