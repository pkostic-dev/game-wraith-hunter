extends Node3D

# TODO : Ghost class ?
const GHOST = preload("res://hunting/ghost.tscn") 
var ghost

# TODO : Fix the whole ghost spawning thing
func _ready():
	if not ghost:
		ghost = GHOST.instantiate()
		get_parent().call_deferred("add_child", ghost)
		if ghost:
			ghost.global_position = global_position + Vector3(randf_range(-10, 10), 0, 0)


func _process(_delta):
	if not ghost:
		ghost = GHOST.instantiate()
		get_parent().call_deferred("add_child", ghost)
		if ghost:
			ghost.global_position = global_position + Vector3(randf_range(-10, 10), 0, 0)
