extends LimitRange

class_name LimitedValue

@export var current_value: float

func _init():
	
	if not on_change_min_value.is_connected(_update_current):
		on_change_min_value.connect(_update_current)
	
	if not on_change_max_value.is_connected(_update_current):
		on_change_max_value.connect(_update_current)

func _update_current():
	current_value = clampf(current_value, min_value, max_value)
