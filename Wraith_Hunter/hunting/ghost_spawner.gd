extends Node3D

# TODO : Ghost class ?
const GHOST = preload("res://hunting/ghost.tscn") 
var ghost


func _process(_delta):
	var spawn_position = Vector3(randf_range(-10, 10), 0, 0)
	if not is_instance_valid(ghost) and is_inside_tree():
		ghost = _spawn_ghost(spawn_position)


func _spawn_ghost(_position):
	var _ghost = GHOST.instantiate()
	get_parent().call_deferred("add_child", _ghost)
	if ghost:
		_ghost.transform.origin = _position
	return _ghost
