extends ShareableResource

class_name LimitRange

signal on_change_max_value
signal on_change_min_value

@export var max_value := 1.0:
	set(value):
		
		if value < min_value:
			value = min_value
		
		max_value = value
		on_change_max_value.emit()

@export var min_value := 0.0:
	set(value):
		
		if value > max_value:
			value = max_value
		
		min_value = value
		on_change_min_value.emit()

func is_in_range(value: float) -> bool:
	return value >= min_value && value <= max_value
