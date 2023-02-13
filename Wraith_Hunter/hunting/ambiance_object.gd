extends Node3D

enum AmbianceSound {
	DOOR_HANDLE_1,
	DOOR_HANDLE_2,
	OPEN_BOOK_1,
	OPEN_BOOK_2,
}

@export_enum("DoorHandle1", "DoorHandle2", "OpenBook1", "OpenBook2") var ambiance_sound:int = 0
@export_range(0, 30, 0.1, "suffix:s", "or_greater") var repeat_time_min:float = 10
@export_range(0, 30, 0.1, "suffix:s", "or_greater") var repeat_time_max:float = 20

@onready var audio_stream_player_3D := $AudioStreamPlayer3D
@onready var repeat_timer := $RepeatTimer
@onready var ambiance_sound_name := $AmbianceSoundName
@onready var repeat_timer_count := $RepeatTimerCount

func _ready():
	# Set the audio to the ambiance object
	match ambiance_sound:
		AmbianceSound.DOOR_HANDLE_1:
			audio_stream_player_3D.stream = load("res://audio/ambiance/action-doorhandle01.wav")
		AmbianceSound.DOOR_HANDLE_2:
			audio_stream_player_3D.stream = load("res://audio/ambiance/action-doorhandle02.wav")
		AmbianceSound.OPEN_BOOK_1:
			audio_stream_player_3D.stream = load("res://audio/ambiance/action-openbook01.wav")
		AmbianceSound.OPEN_BOOK_2:
			audio_stream_player_3D.stream = load("res://audio/ambiance/action-openbook02.wav")
	
	# Start the timer for the first time
	repeat_timer.wait_time = randf_range(repeat_time_min, repeat_time_max)
	repeat_timer.start()
	
	# Change Label3D text to the corresponding sound
	ambiance_sound_name.text = AmbianceSound.keys()[ambiance_sound]


func _process(_delta):
	repeat_timer_count.text = "%.2f sec" % repeat_timer.time_left


func _on_repeat_timer_timeout():
	if not audio_stream_player_3D.playing:
		# Play the sound
		audio_stream_player_3D.play()
		# Change the Label3D text color to green
		ambiance_sound_name.modulate = Color(.2, 1, .2)
	
	# Repeat the timer
	repeat_timer.wait_time = randf_range(repeat_time_min, repeat_time_max)
	repeat_timer.start()


func _on_audio_stream_player_3d_finished():
	# Reset the color to white
	ambiance_sound_name.modulate = Color(1, 1, 1)
