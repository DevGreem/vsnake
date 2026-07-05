extends TileMapLayer

class_name SnakeNode

enum Direction {
	UP = 0,
	DOWN = 1,
	LEFT = 3,
	RIGHT = 4
}

signal on_die(id: int)

@export var table: TableNode:
	set(value):
		
		table = value
		
		if table:
			print("Starting snake")
			update_body()
		
@export var player: int
@export var direction: Direction
@export var speed := 0.1
@export var move_timer: float

@export var boosts: Array[BoostInfo] = []

var body: Array[Vector2i] = []
var can_move := true

func _ready() -> void:
	update_body()
	move_timer = speed

static func generate(start: Vector2i, player_id: int, table_def: TableNode, def_direction := Direction.RIGHT, def_speed := 0.1) -> SnakeNode:
	
	var scene: PackedScene = preload("res://content/snake/snake.tscn")
	var snake: SnakeNode = scene.instantiate()
	snake.body.append(start)
	snake.player = player_id
	snake.table = table_def
	snake.direction = def_direction
	snake.speed = def_speed
	
	return snake

func _process(delta: float):
	
	if not can_move:
		return

	if move_timer <= 0:
		update_body()
		move_timer = get_time(delta)
	else:
		move_timer -= delta

func update_body() -> void:
	print("updated Snake " + str(player))
	
	if body.is_empty() or not can_move:
		return
	
	var front: Vector2i = body.front() + get_axis()
	
	var tile := table.get_cell_source_id(front)
	
	if tile == 1:
		die()
		return
	
	self.set_cell(front, self.player, Vector2i(0, 0))
	
	var food: FoodNode = table.foods.get(front)
	
	if food:
		food.eat(self)
	
	self.erase_cell(body.back())
	
	print("Axis: ", get_axis())
	print("Body: ", body)
	
	body.pop_back()
	
	if front in body:
		self.queue_free()
		return
	
	body.push_front(front)

func eat() -> void:
	
	body.append(body.back())
	update_body()

func get_axis() -> Vector2i:
	
	return Vector2i(
		-1*int(direction == Direction.LEFT) + int(direction == Direction.RIGHT),
		-1*int(direction == Direction.UP) + int(direction == Direction.DOWN)
	)

func _input(event: InputEvent) -> void:
	
	if not can_move:
		return
	
	if event is InputEventKey:
		
		var axis = GameConfig.config.controls[player].get(event.keycode)
		
		print("Pressed the key: ", event.keycode)
		print("With direction: ", axis)
		
		if axis != null:
			
			if _is_reverse_direction(axis):
				return
			
			direction = axis
			print("Changed direction to: ", direction)

func _is_reverse_direction(new_direction: Direction) -> bool:
	return new_direction + 1 == direction or new_direction - 1 == direction

static func direction_to_string(_direction: Direction) -> String:
	
	for _name in Direction:
		if Direction[_name] == _direction:
			return _name
	
	return ""

func die() -> void:
	print("Died snake: ", player)
	on_die.emit(player)
	self.queue_free()

func get_time(delta: float) -> float:
	
	var new_time = speed
	
	for i in range(boosts.size()):
		var boost := boosts[i]
		
		if boost.boost_time <= 0:
			boosts.erase(i)
			continue
		
		boost.boost_time -= delta
		
		new_time *= boost.speed_boost
	
	return new_time
