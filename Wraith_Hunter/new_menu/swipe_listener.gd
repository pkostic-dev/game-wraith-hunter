extends Node

var waiting_for_release:bool = false


func _process(_delta):
	pass


func _input(event):
	if (event is InputEventScreenDrag) and not waiting_for_release:
		print(event)
		if event.velocity.x < -2000:
			var ui_right = InputEventAction.new()
			ui_right.action = "ui_right"
			ui_right.pressed = true
			Input.parse_input_event(ui_right)
			waiting_for_release = true
		if event.velocity.x > 2000:
			var ui_left = InputEventAction.new()
			ui_left.action = "ui_left"
			ui_left.pressed = true
			Input.parse_input_event(ui_left)
			waiting_for_release = true
		if event.velocity.y > 2000:
			var ui_up = InputEventAction.new()
			ui_up.action = "ui_up"
			ui_up.pressed = true
			Input.parse_input_event(ui_up)
			waiting_for_release = true
		if event.velocity.y < -2000:
			var ui_down = InputEventAction.new()
			ui_down.action = "ui_down"
			ui_down.pressed = true
			Input.parse_input_event(ui_down)
			waiting_for_release = true
	if event is InputEventScreenTouch:
		print(event)
		if not event.pressed:
			if waiting_for_release:
				waiting_for_release = false
				return
#			var screen_size = DisplayServer.window_get_size()
#(event.position.x > screen_size.x/5) and (event.position.x < (screen_size.x - screen_size.x/5)):
			var ui_accept = InputEventAction.new()
			ui_accept.action = "ui_accept"
			ui_accept.pressed = true
			Input.parse_input_event(ui_accept)
