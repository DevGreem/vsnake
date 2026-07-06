extends Button

@onready var max_food: SpinBox = $"../../MaxFood/Value"
@onready var time_food: SpinBox = $"../../TimeFood/Value"
@onready var snake_speed: SpinBox = $"../../SnakeSpeed/Value"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if not pressed.is_connected(_on_pressed):
		pressed.connect(_on_pressed)

func _on_pressed() -> void:
	
	var match_scene: MatchNode = preload("res://scenes/match/match.tscn").instantiate()
	
	var table: TableNode = match_scene.get_node("Map/Table")
	
	match_scene.default_snakes_speed = snake_speed.value
	table.food_limit = int(max_food.value)
	table.food_cooldown = time_food.value
	
	get_tree().change_scene_to_node(match_scene)
