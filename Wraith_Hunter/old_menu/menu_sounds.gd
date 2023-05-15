extends Node


func play_confirm():
	print("confirm")
	$Confirm.play()

func play_cancel():
	$Cancel.play()
	
func play_pointer():
	print("pointer")
	$Pointer.play()
