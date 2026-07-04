extends TileMapLayer

class_name SnakeNode

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

@export var table: TileMapLayer:
	set(value):
		
		table = value
		
		if table:
			print("Starting snake")
			update_body()
		
@export var player: int
@export var direction: Direction

var body: Array[Vector2i] = []

func _ready() -> void:
	update_body()

static func generate(start: Vector2i, player_id: int, table_def: TableNode, def_direction := Direction.RIGHT) -> SnakeNode:
	
	var scene: PackedScene = preload("res://content/snake/snake.tscn")
	var snake: SnakeNode = scene.instantiate()
	snake.body.append(start)
	snake.player = player_id
	snake.table = table_def
	snake.direction = def_direction
	
	return snake

func update_body() -> void:
	print("updated Snake " + str(player))
	
	if body.is_empty():
		return
	
	var front: Vector2i = body.front() + get_axis()
	self.set_cell(front, self.player+1, Vector2(0, 0))
	self.erase_cell(body.back())
	
	print("Axis: ", get_axis())
	print("Body: ", body)
	body.push_front(front)
	body.pop_back()

func eat() -> void:
	
	body.append(body.back())
	update_body()

func get_axis() -> Vector2i:
	
	return Vector2i(
		-1*int(direction == Direction.LEFT) + int(direction == Direction.RIGHT),
		-1*int(direction == Direction.UP) + int(direction == Direction.DOWN)
	)

func _input(event: InputEvent) -> void:
	
	if event is InputEventKey:
		
		var axis: Direction = GameConfig.config.controls[player].get(event.keycode)
		
		if axis:
			direction = axis
			print("Changed direction to: ", direction)
