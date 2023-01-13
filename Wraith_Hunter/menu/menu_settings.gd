extends Node3D

var swipe_start = null
var minimum_drag = 100
var largeur_ecran = 1150

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_retour_pressed():
	var scene = "res://menu/menu_main.tscn"
	var err = get_tree().change_scene_to_file(scene)
	if err != OK:
		printerr("La scene %s n'existe pas!" % scene) # Replace with function body.

# Prise en compte du swipe
func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			swipe_start = event.get_position()
		else:
			_calculate_swipe(event.get_position())
			

func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		return
	var swipe = swipe_end - swipe_start
	if abs(swipe.x) > minimum_drag:
		if swipe.x > 0:
			_right()
		else:
			_left()

 # Action au swipe right
func _right():
	$Container/StartGameContainer.position.x -= largeur_ecran

 # Action au swipe left
func _left():
	$Container/StartGameContainer.position.x += largeur_ecran

