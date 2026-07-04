extends TileMapLayer

class_name TableNode

@export var spawns: Array[Vector2i] = []
@export var entities: Node

func _ready():
	generate_snakes()

func generate_snakes() -> void:
	
	for i in range(spawns.size()):
		var spawn := spawns[i]
		
		spawn.y += 1
		
		var snake := SnakeNode.generate(spawn, i, self)
		
		entities.add_child(snake)
