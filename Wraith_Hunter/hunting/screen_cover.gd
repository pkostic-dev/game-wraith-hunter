extends CanvasLayer

@onready var black_rect := $BlackRect


func _on_toggle_cover_toggled(button_pressed):
	if button_pressed:
		$Polygon2D.visible = true
		#black_rect.visible = true
	else:
		$Polygon2D.visible = false
		#black_rect.visible = false
