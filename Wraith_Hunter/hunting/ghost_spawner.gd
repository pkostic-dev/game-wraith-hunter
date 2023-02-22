extends Node3D


const GHOST = preload("res://hunting/ghost.tscn") 

var ghosts_left = 3

var ghost


func _process(_delta):
	var spawn_position = Vector3(randf_range(-10, 10), 0, 0)
	if not is_instance_valid(ghost) and is_inside_tree() and ghosts_left > 0:
		ghost = _spawn_ghost(spawn_position)
		ghosts_left -= 1
	
	if ghosts_left == 0:
		Game.next_level()


func _spawn_ghost(_position):
	var _ghost = GHOST.instantiate()
	get_parent().call_deferred("add_child", _ghost)
	if ghost:
		_ghost.transform.origin = _position
		match Config.config.difficulty:
			Config.Difficulty.EASY:
				pass
			Config.Difficulty.MEDIUM:
				_ghost.homing_speed = .3
			Config.Difficulty.HARD:
				_ghost.homing_speed = .4
				_ghost.move_during_capture = true
	return _ghost
