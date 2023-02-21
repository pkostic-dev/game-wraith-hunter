extends Node3D

var TUTORIAL_AIM := load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_AIM.wav")
var TUTORIAL_CAPTURE_END := load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_CAPTURE_END.wav")
var TUTORIAL_CAPTURE_READY := load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_CAPTURE_READY.wav")
var TUTORIAL_CAPTURE_START := load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_CAPTURE_START.wav")
var TUTORIAL_LOW_HEALTH_1 := load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_LOW_HEALTH_1.wav")
var TUTORIAL_LOW_HEALTH_2 := load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_LOW_HEALTH_2.wav")
var TUTORIAL_LOW_HEALTH_3 := load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_LOW_HEALTH_3.wav")
var TUTORIAL_PAUSE := load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_PAUSE.wav")
var TUTORIAL_WRAITH := load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_WRAITH.wav")
var TUTORIAL_WRAITH_ATTACK_1 := load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_WRAITH_ATTACK_1.wav")
var TUTORIAL_WRAITH_ATTACK_2 := load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_WRAITH_ATTACK_2.wav")
var TUTORIAL_WRAITH_MOVE := load("res://audio/tutorial/" + Config.config.language + "/TUTORIAL_WRAITH_MOVE.wav")

# SFX
var WRAITH_GROWL := load("res://audio/sound_fx/ghost/creature-growl01.wav")
var WRAITH_ATTACK := load("res://audio/sound_fx/ghost/Monster_Roar_2.wav")
var LOW_HEALTH := load("res://audio/sound_fx/player/human-breathingrapid01.wav") #TODO change to heartbeat

# Flags
var aim_success := false
var screen_touched := false
var ghost_dead := false

var OPENING_SEQUENCE := "res://sequences/opening/opening_sequence.tscn"

const GHOST = preload("res://hunting/ghost.tscn") 
var ghost

# Sequence
# 1. Play WRAITH_GROWL
# 2. Play TUTORIAL_WRAITH
# 3. Play TUTORIAL_AIM
# 4. Wait for aim_success == true
# 5. Play TUTORIAL_CAPTURE_READY
# 6. Play TUTORIAL_CAPTURE_START
# 7. Wait for screen_touched == true
# 8. Wait for ghost_dead == true
# 9. Play TUTORIAL_CAPTURE_END
# 10. Play TUTORIAL_WRAITH_ATTACK_1
# 11. Play WRAITH_ATTACK, TUTORIAL_WRAITH_ATTACK_2
# 12. Play TUTORIAL_LOW_HEALTH, low health sfx, low health vibration
# 13. Play TUTORIAL_WRAITH_MOVE
# 14. Play TUTORIAL_PAUSE


func _ready():
	# Create a ghost
	var spawn_position = Vector3(randf_range(-9, 9), 0, 0)
	ghost = await _spawn_ghost()
	ghost.set_process(false)
	ghost.behavior = ghost.Behavior.IDLE
	ghost.default_behavior = ghost.Behavior.IDLE
	ghost.original_position = spawn_position
	ghost.position = spawn_position
	
	
	_start_sequence()


func _start_sequence():
	$Player.can_aim = false
	
	_play_sound(WRAITH_GROWL)
	await get_tree().create_timer(2.0).timeout
	$TutorialAudio.stop()
	
	_play_sound(TUTORIAL_WRAITH)
	await $TutorialAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	_play_sound(TUTORIAL_AIM)
	await $TutorialAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	$Player.can_aim = true
	await $Player.wraith_locked_on
	$Player.can_aim = false
	
	_play_sound(TUTORIAL_CAPTURE_READY)
	await $TutorialAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	_play_sound(TUTORIAL_CAPTURE_START)
	await $TutorialAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	ghost.set_process(true)
	await ghost.died
	
	_play_sound(TUTORIAL_CAPTURE_END)
	await $TutorialAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	_play_sound(TUTORIAL_WRAITH_ATTACK_1)
	await $TutorialAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	_play_sound(WRAITH_ATTACK)
	await $TutorialAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	_play_sound(TUTORIAL_WRAITH_ATTACK_2)
	await $TutorialAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	_play_sound(TUTORIAL_LOW_HEALTH_1)
	await $TutorialAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	_play_sound(LOW_HEALTH)
	await $TutorialAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	_play_sound(TUTORIAL_LOW_HEALTH_2)
	await $TutorialAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	Input.vibrate_handheld(400)
	await get_tree().create_timer(1.0).timeout
	
	_play_sound(TUTORIAL_LOW_HEALTH_3)
	await $TutorialAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	_play_sound(TUTORIAL_WRAITH_MOVE)
	await $TutorialAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	_play_sound(TUTORIAL_PAUSE)
	await $TutorialAudio.finished
	await get_tree().create_timer(1.0).timeout
	
	Global.goto_scene(OPENING_SEQUENCE)


func _play_sound(stream):
	if $TutorialAudio.playing:
		$TutorialAudio.stop()
	$TutorialAudio.stream = stream
	$TutorialAudio.play()

func _spawn_ghost():
	var _ghost = GHOST.instantiate()
	call_deferred("add_child", _ghost)
	return _ghost
