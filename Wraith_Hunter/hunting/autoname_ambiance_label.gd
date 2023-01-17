@tool
extends Label3D

# This script, being annotated with @tool, will run in the editor allowing for
# real-time automatic change of Label3D text for debugging

func _process(_delta):
	if Engine.is_editor_hint():
		text = get_parent().AmbianceSound.keys()[get_parent().ambiance_sound]
