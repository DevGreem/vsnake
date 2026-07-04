extends Button


func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		
		if self.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			get_tree().quit()
