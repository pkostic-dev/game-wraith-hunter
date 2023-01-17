extends CanvasLayer

@onready var black_rect := $BlackRect

func _on_toggle_cover_toggled(button_pressed):
	if button_pressed:
		black_rect.visible = true
	else:
		black_rect.visible = false
