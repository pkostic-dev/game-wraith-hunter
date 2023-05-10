extends Node


func _process(_delta):
	pass


func _input(event):
	if event is InputEventScreenDrag:
		print(event)
