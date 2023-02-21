extends Node
var swipe_start = null
var minimum_drag = 100
var current_scene
var buttons_group
signal swipe_right
signal swipe_left
var x_min
var x_max = 0
var nb_buttons

func swipe_event(event, container, buttons):
	current_scene = container
	buttons_group = buttons
	nb_buttons = buttons_group.size()-1
	x_min = -1150 * nb_buttons
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
		for button in buttons_group:
			button.disabled = true
		if swipe.x > 0:
			_right()
		else:
			_left()

func _right():
	print("swipe right")
	swipe_right.emit()

func _left():
	print("swipe left")
	swipe_left.emit()
	
func move_scene_right():
	if current_scene.position.x >= x_max:
		current_scene.position.x -= 1150 * nb_buttons
	else:
		current_scene.position.x += 1150
	for button in buttons_group:
		button.disabled = false

func move_scene_left():
	if current_scene.position.x <= x_min:
		current_scene.position.x = 0
	else:
		current_scene.position.x -= 1150
	for button in buttons_group:
		button.disabled = false
