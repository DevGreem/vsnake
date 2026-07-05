extends Button

class_name KeyDetector

var waiting := false
var selected_key: Key

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize()

func initialize() -> void:
	
	if not self.pressed.is_connected(_on_pressed):
		self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	waiting = true

func _gui_input(event: InputEvent) -> void:
	
	if not waiting:
		return
	
	if event is InputEventKey:
		
		waiting = false
		
		if event.keycode == Key.KEY_ESCAPE:
			return
		
		selected_key = event.keycode
		
		self.text = event.as_text()

func _input(event: InputEvent):
	
	if event is InputEventMouseButton:
		waiting = false
