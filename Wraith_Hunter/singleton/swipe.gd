extends Node
var swipe_start = null
var minimum_drag = 100
var current_scene
var swiping
var buttons_group
signal swipe_right
signal swipe_left



func swipe_event(event, container, buttons):
	current_scene = container
	buttons_group = buttons
	if event is InputEventScreenTouch:
		if event.pressed:
			swipe_start = event.get_position()
			#print("swipe start")
		else:
			#print("swipe end")
			_calculate_swipe(event.get_position())


func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		#print("null")
		return
	var swipe = swipe_end - swipe_start
	if abs(swipe.x) > minimum_drag:
		#swiping = true
		for button in buttons_group:
			button.disabled = true
		if swipe.x > 0:
			_right()
		else:
			_left()

func get_swiping():
	return swiping

func _right():
	print("swipe right")
	swiping = "right"
	current_scene.position.x -= 1150
	for button in buttons_group:
		button.disabled = false
	swipe_right.emit()


func _left():
	swiping = "left"
	print("swipe left")
	current_scene.position.x += 1150
	for button in buttons_group:
		button.disabled = false
	swipe_left.emit()
