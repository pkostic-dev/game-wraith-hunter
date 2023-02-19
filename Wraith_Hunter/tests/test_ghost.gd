extends Node3D

enum Behavior {
	IDLE,
	SIDE_TO_SIDE,
}

@export_enum("Idle", "SideToSide") var behavior:int = 0
@export var emit_sound:bool = true
@export var sound_timer_delay:float = 0.3


func _ready():
	match behavior:
		Behavior.IDLE:
			pass
		Behavior.SIDE_TO_SIDE:
			_start_side_to_side()
	
	if emit_sound:
		$TestSoundTimer.wait_time = sound_timer_delay
		$TestSoundTimer.start()


func _process(_delta):
	pass


func _start_side_to_side():
	var _tween := get_tree().create_tween()
	var _left = -10
	var _right = 10
	var _duration = 5
	var _loops = 100
	
	_tween.tween_property(self, "position", Vector3(_right, position.y, position.z), _duration)
	_tween.tween_property(self, "position", Vector3(_left, position.y, position.z), _duration)
	
	_tween.set_loops(_loops)


func _on_test_sound_timer_timeout():
	$TestSound.play()
	$TestSoundTimer.start()
