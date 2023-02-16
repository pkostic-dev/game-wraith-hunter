extends Node3D
#var buttons = ["start", "settings"]
#var current_button = 0
#signal swipe_right
#signal swipe_left
var focus_button

func _ready():
	var button_start = %Container/StartGame
	%StartGame.grab_focus()
	focus_button = button_start
	#print(focus_button)
	#var main_menu = get_node("menu_main")
	#main_menu.swipe_right.connect(_on_swipe_right)
#	var swipe_node = get_tree().get_root().find("Swipe",true, false)
#	swipe_node.connect("swipe_right",self,"on_swipe_right")
	var swipe_singleton = Swipe.get_signal_list()
	print("singleton signal :")
	print(swipe_singleton)
	Swipe.swipe_left.connect(_on_swipe_left)
	Swipe.swipe_right.connect(_on_swipe_right)
	
	
	
#func _process(delta):
#	var swipe = Swipe.get_swiping()
#	if swipe == "swipe_right":
#		print("swipe right detected")
#		#emit_signal("swipe_right")
#		swipe_right.emit()
#	if swipe == "swipe_left":
#		#emit_signal("swipe_left")
#		swipe_left.emit()

func _unhandled_input(event):
	var buttons = get_tree().get_nodes_in_group("buttons")

	Swipe.swipe_event(event, $Container, buttons)
	var swipe = Swipe.get_swiping()
	#print(swipe)
	if swipe == "swipe_right":
		print("swipe right detected")
			#emit_signal("swipe_right")
		#swipe_right.emit()
	if swipe == "swipe_left":
		pass
			#emit_signal("swipe_left")
		#swipe_left.emit()
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
	#print("swipe left signal")
	focus_button = focus_button.find_next_valid_focus()
	focus_button.grab_focus()
	print(focus_button)
	#print(focus_button)
	#var control = self.get_focus_owner()
	#print(control)
	#var next_focus = control.find_next_valid_focus()
	#print(next_focus)
	#next_focus.grab_focus()
	
func _on_swipe_right():
	#print("swipe right signal")
	#var control = get_node($Container.get_focus_owner)
	#print(control)
	print("focus button")
	print(focus_button)
	focus_button = focus_button.find_prev_valid_focus()
	focus_button.grab_focus()

	print("new focus")
	print(focus_button)


func _on_settings_pressed():
		Global.goto_scene("res://menu/settings_menu.tscn")

func _on_start_game_pressed():
	pass # Replace with function body.

func _on_start_game_focus_entered():
	%StartGameSound.play(0)

func _on_settings_focus_entered():
	%SettingsSound.play(0)


