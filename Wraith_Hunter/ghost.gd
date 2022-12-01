extends Node3D


func _ready():
	var tween := get_tree().create_tween()
	tween.tween_property(self, "position", Vector3(10, position.y, position.z), 1)
	tween.tween_property(self, "position", Vector3(-10, position.y, position.z), 1)
	tween.set_loops(20)


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		$AudioStreamPlayer3D.play()
