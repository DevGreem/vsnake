extends Sprite2D

class_name FoodNode

signal on_eated

@export var info: FoodInfo:
	set(value):
		
		info = value
		_initialize()

@export var table_position: Vector2i

func _ready():
	_initialize()

func _initialize():
	
	if not info:
		return
	
	texture = info.texture

func eat(snake: SnakeNode) -> void:
	on_eated.emit()
	
	for i in range(info.length):
		snake.body.push_back(snake.body.back())
	
	if info.boost:
		snake.boosts.append(info.boost)
	
	self.queue_free()
