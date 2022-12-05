extends Node3D

# _ready() est une fonction built-in de Godot qui s'éxécute une seule fois quand
# l'objet est crée
func _ready():
	# Créer un objet Tween qui est utilisé pour gèrer les animations dans le code
	var tween := get_tree().create_tween()
	
	# Crée et attache un objet PropertyTweener à l'objet Tween
	# Cet objet permet d'interpoler une proprieté entre deux valeurs
	# tween_property(l'objet, la proprieté à interpoler, la valeur finale, la durée)
	# self : équivalent au 'this' en Java, on veut interpoler la valeur de l'objet
	#        sur lequel ce script est attaché (ghost)
	# "position" : il faut donner le nom de la propriété à interpoler dans la forme 
	#              d'une chaîne de caractères, variable du type Vector3D
	# Vector3(..) : on construit un Vector3 avec les 3 valeurs données
	#               la position ici c'est la même que dans le deuxieme argument
	#               c'est la position de cet objet dans lequel on est donc pas besoin
	#               d'indiquer qui s'est, ou de mettre self.position
	# la durée est en une valeur en secondes (c'est un float donc on peut mettre 1.5 aussi)
	tween.tween_property(self, "position", Vector3(10, position.y, position.z), 1)
	tween.tween_property(self, "position", Vector3(-10, position.y, position.z), 1)
	# set_loops permet de répéter l'animation plusieurs fois, la sequence des deux
	# tweens en haut sera donc répété 20 fois
	tween.set_loops(20)


# _process() est une fonction built-in de Godot qui s'éxécute en boucle
# delta ou _delta (on prefixe par _ toutes les variables qu'on n'utilise pas dans le code
# pour ne pas avoir des Warnings da le Debugger) est une variable obligatoire pour la
# fonction _process(), elle contient le temps écoulé depuis la dérniere fois que cette
# fonction a été executé (ça permet de faire des calculs en temps réel peu importe si un
# ordinateur est rapide ou pas)
func _process(_delta):
	# Input est un objet qui contient des fonctions liées à la saisie du
	# clavier/souris etc.
	# is_action_just_pressed() prend comme argument le nom d'une action (elles sont
	# définies dans Project > Project Settings > Input Map (cocher Show Built-in Actions)
	# et il renvoie vrai si cette action a été déclenché à l'instant(!) (opposé à
	# is_action_pressed() (sans just) qui renvoie vrai en continu)
	# Dans ce cas "ui_accept" est une action liée à Entrée et Espace
	if Input.is_action_just_pressed("ui_accept"):
		# le $ est un raccourci de la fonction get_node("AudioStreamPlayer3D")
		# cette fonction permet de acceder à un objet enfant de l'objet dans lequel on se 
		# trouve par son identifiant
		# La fonction play() permet de joueur le son de cet objet AudioStreamPlayer3D
		$AudioStreamPlayer3D.play()
