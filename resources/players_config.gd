extends Resource

class_name PlayersConfig

@export var controls: Array[Dictionary] = [
	{
		Key.KEY_W: SnakeNode.Direction.UP,
		Key.KEY_S: SnakeNode.Direction.DOWN,
		Key.KEY_A: SnakeNode.Direction.LEFT,
		Key.KEY_D: SnakeNode.Direction.RIGHT
	},
	{
		Key.KEY_UP: SnakeNode.Direction.UP,
		Key.KEY_DOWN: SnakeNode.Direction.DOWN,
		Key.KEY_LEFT: SnakeNode.Direction.LEFT,
		Key.KEY_RIGHT: SnakeNode.Direction.RIGHT
	}
]
