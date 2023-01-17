extends Node3D

@export var speed:float = .5
@export_range(0, 30, 0.1, "suffix:s", "or_greater") var repeat_time_min:float = 7
@export_range(0, 30, 0.1, "suffix:s", "or_greater") var repeat_time_max:float = 9

# TODO : make finding the player cleaner
@onready var player := get_parent().get_node("Player")
@onready var audio_stream_player_3D := $AudioStreamPlayer3D
@onready var sound_timer := $SoundTimer
@onready var ghost_emoji := $GhostEmoji


func _ready():
	# Play the sound
	audio_stream_player_3D.play()
	
	# Start the timer for the first time
	sound_timer.wait_time = randf_range(repeat_time_min, repeat_time_max)
	sound_timer.start()


func _physics_process(delta):
	if player:
		var player_direction = (player.position - position).normalized()
		global_translate(speed * player_direction * delta)


func _on_sound_timer_timeout():
	if not audio_stream_player_3D.playing:
		# Play the sound
		audio_stream_player_3D.play()
		# Change the GhostEmoji text color to green
		ghost_emoji.modulate = Color(.2, 1, .2)
	
	# Repeat the timer
	sound_timer.wait_time = randf_range(repeat_time_min, repeat_time_max)
	sound_timer.start()


func _on_audio_stream_player_3d_finished():
	# Reset the color to white
	ghost_emoji.modulate = Color(1, 1, 1)
