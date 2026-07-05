extends TileMapLayer

class_name TableNode

@export var spawns: Dictionary[Vector2i, SnakeNode.Direction] = {}
@export var entities: Node
@export var food_limit := 1
@export var food_cooldown := 1.0
var food_timer: float
@export var foods: Dictionary[Vector2i, FoodNode] = {}

const FOODS_DATABASE: Registry = preload("res://databases/foods.tres")
var IDS: Array[StringName] = []

var generate_food := false

func _ready():
	food_timer = food_cooldown
	
	IDS = FOODS_DATABASE.get_all_string_ids()

func _process(delta: float):
	
	if foods.size() >= food_limit or not generate_food:
		return
	
	if food_timer <= 0:
		food_timer = food_cooldown
		
		var food_info: FoodInfo = FOODS_DATABASE.load_entry(IDS.pick_random()).duplicate()
		var pos := Vector2i(randi_range(1, 38), randi_range(1, 21))
		
		while pos in foods:
			pos = Vector2i(randi_range(1, 38), randi_range(1, 21))
		
		var food := FoodNode.new()
		food.info = food_info
		food.table_position = pos
		food.position = map_to_local(pos)
		food.on_eated.connect(func(): _on_eat_food(pos))
		
		foods[pos] = food
		
		add_child(food)
		
		print("Generated new food")
	else:
		food_timer -= delta

func _on_eat_food(pos: Vector2i) -> void:
	foods.erase(pos)
