extends Node

## Listens for screen input events and feeds action input events.
##
## Listens for [InputEventScreenDrag] and [InputEventScreenTouch] events and 
## simulates ui action events by generating [method Node._input] calls with the 
## built-in [method Input.parse_input_event] method.[br][br]The default actions
## are set to the opposite of the swipe direction (i.e. swiping left will
## generate a [code]ui_right[/code] event).


## This variable is [code]true[/code] if a proper dragging event is generated,
## and no more can be generated until it is set to [code]false[/code] again.
var waiting_for_release:bool = false

const SWIPE_LEFT:String = "ui_right"
const SWIPE_RIGHT:String = "ui_left"
const SWIPE_UP:String = "ui_down"
const SWIPE_DOWN:String = "ui_up"
const TOUCH_RELEASE:String = "ui_accept"


## Checks for the [InputEventScreenDrag] and [InputEventScreenTouch] events. 
func _input(event):
	check_screen_drag(event)
	check_touch_release(event)


## Checks for the [InputEventScreenDrag] event and if
## [member waiting_for_release] is [code]false[/code] generates input events
## based on [member InputEventScreenDrag.velocity].
func check_screen_drag(event:Variant) -> void:
	if (event is InputEventScreenDrag) and not waiting_for_release:
		if event.velocity.x < -2000:
			generate_input_event(SWIPE_LEFT)
		if event.velocity.x > 2000:
			generate_input_event(SWIPE_RIGHT)
		if event.velocity.y > 2000:
			generate_input_event(SWIPE_DOWN)
		if event.velocity.y < -2000:
			generate_input_event(SWIPE_UP)


## Checks for the [InputEventScreenTouch] event and if 
## [member InputEventScreenTouch.pressed] is [code]false[/code]. If 
## [member waiting_for_release] is [code]true[/code], sets it to 
## [code]false[/code], else generates the [code]ui_accept[/code] input event.
func check_touch_release(event:Variant) -> void:
	if event is InputEventScreenTouch:
		if not event.pressed:
			if waiting_for_release:
				waiting_for_release = false
				return
			generate_input_event(TOUCH_RELEASE)


## Generates an input event call for a specific action. By default the 
## [code]pressed[/code] property is set to [code]true[/code].
func generate_input_event(action:String, pressed:bool = true) -> void:
	var event = InputEventAction.new()
	event.action = action
	event.pressed = pressed
	Input.parse_input_event(event)
	waiting_for_release = true
