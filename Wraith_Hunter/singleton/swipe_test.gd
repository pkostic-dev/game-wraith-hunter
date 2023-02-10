extends Control

signal swipe_left
signal swipe_right
signal swipe_up
signal swipe_down

var start_x
var start_y
var swipe_threshold = 100

func _input_event(event):
	if event is InputEventScreenDrag and event.index == 0 and event.drag_begin:
		start_x = event.x
		start_y = event.y
	elif event is InputEventScreenDrag and event.index == 0 and event.drag_end:
		var delta_x = event.x - start_x
		var delta_y = event.y - start_y

		if abs(delta_x) > swipe_threshold:
			if delta_x > 0:
				emit_signal("swipe_right")
			else:
				emit_signal("swipe_left")
		elif abs(delta_y) > swipe_threshold:
			if delta_y > 0:
				emit_signal("swipe_down")
			else:
				emit_signal("swipe_up")
