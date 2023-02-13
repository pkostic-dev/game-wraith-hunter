extends Node3D
var buttons = ["start", "settings"]
var current_button = 0
signal swipe_right
signal swipe_left


func _ready():
	%StartGame.grab_focus()
	
	#Swipe.connect("swipe_right", , _on_swipe_right())
#	var swipe_node = get_tree().get_root().find("Swipe",true, false)
#	swipe_node.connect("swipe_right",self,"on_swipe_right")

func _process(delta):
	
	
	var swipe = Swipe.get_swiping
	if swipe == "swipe_right":
		emit_signal("swipe_right")
	if swipe == "swipe_right":
		emit_signal("swipe_left")

func _unhandled_input(event):
	var buttons = get_tree().get_nodes_in_group("buttons")
	print(event.as_text())
	Swipe.swipe_event(event, $Container, buttons)
	
#liste bouton
#var current_button = 0

#ui_focus_prev or next
#swipe right -1 ou lft +1
#si >max on reprend à 0
#si <min on va au max
#joué son current bouton
#clic -> exécuté action lié au bouton

#soit swipe renvoie une valeur
#soit le changement se fait dedans
#enlever le signal du clic
#changer le focus avec le swipe
#quand clic dans minimum drag c'est un clic

func _on_swipe_left():
	var control = get_node($Container.get_focus_owner)
	print(control)
	var next_focus = control.find_next_valid_focus()
	print(next_focus)
	next_focus.grab_focus()
	
func _on_swipe_right():
	
	print("swipe right signal")
	var control = get_node($Container.get_focus_owner)
	print(control)
	var previous_focus = control.find_previous_valid_focus()
	print(previous_focus)
	previous_focus.grab_focus()





func _on_settings_pressed():
		Global.goto_scene("res://menu/settings_menu.tscn")

func _on_start_game_pressed():
	pass # Replace with function body.

func _on_start_game_focus_entered():
	%StartGameSound.play(0)

func _on_settings_focus_entered():
	%SettingsSound.play(0)


