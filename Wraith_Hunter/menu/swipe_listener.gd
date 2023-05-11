extends Node

## Listens for screen input events and feeds action input events.
##
## Listens for [InputEventScreenDrag] and [InputEventScreenTouch] events and 
## simulates ui action events by generating [method Node._input] calls with
## [method Input.parse_input_event].


## True if a proper dragging event is generated, and no more can be generated 
## until it is set to [code]false[/code] again.
var waiting_for_release:bool = false


## Checks for screen dragging and generates input events based on the velocity.
## If [member waiting_for_release] is [code]true[/code] 
func _input(event):
	if (event is InputEventScreenDrag) and not waiting_for_release:
		if event.velocity.x < -2000:
			generate_input_event("ui_right")
		if event.velocity.x > 2000:
			generate_input_event("ui_left")
		if event.velocity.y > 2000:
			generate_input_event("ui_up")
		if event.velocity.y < -2000:
			generate_input_event("ui_down")
	if event is InputEventScreenTouch:
		if not event.pressed:
			if waiting_for_release:
				waiting_for_release = false
				return
			generate_input_event("ui_accept")


## Generates an input event call for a specific action.
func generate_input_event(action:String, pressed:bool = true) -> void:
	var event = InputEventAction.new()
	event.action = action
	event.pressed = pressed
	Input.parse_input_event(event)
	waiting_for_release = true
