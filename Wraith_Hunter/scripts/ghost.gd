extends Node3D


func _ready():
	#var tween := get_tree().create_tween()
	
	#tween.tween_property(self, "position", Vector3(10, position.y, position.z), 5)
	#tween.tween_property(self, "position", Vector3(-10, position.y, position.z), 5)

	#tween.set_loops(100)
	
	$TestSoundTimer.wait_time = 0.3
	$TestSoundTimer.start()


func _process(_delta):
	pass


func _on_test_sound_timer_timeout():
	$TestSound.play()
	$TestSoundTimer.start()
