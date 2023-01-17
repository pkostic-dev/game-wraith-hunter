extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_vibrate_short_pressed():
	Input.vibrate_handheld(100)


func _on_vibrate_pressed():
	Input.vibrate_handheld()


func _on_vibrate_long_pressed():
	Input.vibrate_handheld(1000)
