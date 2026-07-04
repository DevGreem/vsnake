extends Camera2D
class_name ZoomableCamera

@export var default_zoom := Vector2(1, 1)
@export var zoom_speed := Vector2(0.1, 0.1)
@export var min_zoom := Vector2(0.5, 0.5)
@export var max_zoom := Vector2(2.0, 2.0)

@export var zoom_action: StringName
@export var unzoom_action: StringName

@export var zoom_delay := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(InputMap.has_action(zoom_action), 'You don\'t have an action called "' + zoom_action + '"!')
	assert(InputMap.has_action(unzoom_action), 'You don\'t have an action called "' + unzoom_action + '"!')
	zoom = default_zoom

func _input(event: InputEvent):
	
	if not event is InputEventMouse:
		return
	
	var new_val := zoom
	
	if event.is_action(zoom_action):
		new_val += zoom_speed
	
	if event.is_action(unzoom_action):
		new_val -= zoom_speed
	
	new_val.x = clamp(new_val.x, min_zoom.x, max_zoom.x)
	new_val.y = clamp(new_val.y, min_zoom.y, max_zoom.y)
	
	var tween := create_tween()
	tween.tween_property(self, "zoom", new_val, zoom_delay)
