extends Node
var swipe_start = null
var minimum_drag = 100
var current_scene


func swipe_event(event, container):
	current_scene = container
	if event is InputEventScreenTouch:
		if event.pressed:
			swipe_start = event.get_position()
			print("swipe start")
		else:
			print("else")
			_calculate_swipe(event.get_position())


func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		print("null")
		return
	var swipe = swipe_end - swipe_start
	if abs(swipe.x) > minimum_drag:
		if swipe.x > 0:
			_right()
		else:
			_left()
	else:
		print("swipe too small")

func _right():
	print("swipe right")
	current_scene.position.x -= 1150

	
func _left():
	print("swipe left")
	current_scene.position.x += 1150
