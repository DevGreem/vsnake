extends CenterContainer

@export var match_node: MatchNode
@onready var continue_button: Button = $Menu/Container/Continue

func _ready():
	
	if not continue_button.pressed.is_connected(_on_pressed):
		continue_button.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	
	match_node.resume()
	hide()
