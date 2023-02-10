extends Node3D
#var buttons = ["start", "settings"]
#var current_button = buttons[0]

func _unhandled_input(event):
	var buttons = get_tree().get_nodes_in_group("buttons")
	print(event.as_text())
	Swipe.swipe_event(event, $Container, buttons)
	#var swiping = Swipe.get_swiping()
	#if swiping :
	#	for button in buttons_:
	#		button.disabled = true
	#if !swiping:
	#	for button in buttons_:
	#		button.disabled = false
		#get_tree().get_nodes_in_group("buttons")
		#get_node("Container/StartGame").disabled(true)
		#print(InputMap.get_actions())
	#if event is InputEventScreenDrag:
	#	print("screen drag")
	#	Swipe.swipe_event(event, $Container)
	#if event is InputEventScreenTouch : 
	#	print("screen touch")

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


func _on_settings_pressed():
		Global.goto_scene("res://menu/settings_menu.tscn")

func _on_start_game_pressed():
	pass # Replace with function body.

func _on_start_game_focus_entered():
	%StartGameSound.play(0)

func _on_settings_focus_entered():
	%SettingsSound.play(0)


