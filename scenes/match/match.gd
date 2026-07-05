extends Node2D

class_name MatchNode

@export var entities: Node
var ended := false
var started := false

const modulations: Array[Color] = [
	Color.BLUE,
	Color.RED,
	Color.GREEN,
	Color.YELLOW
]
var players: Dictionary[int, SnakeNode] = {}
@onready var table: TableNode = $"Map/Table"

@onready var pause_menu: CenterContainer = $CanvasLayer/Pause
@onready var win_menu: WinMenuNode = $CanvasLayer/Win


#TODO: Add functionality to "Continue" button on pause game
#TODO: Add change label text on end the match
func _ready():
	generate_snakes()

func generate_snakes() -> void:
	
	var count := 0
	
	for spawn in table.spawns:
		var direction := table.spawns[spawn]
		
		spawn.y += 1
		
		var snake := SnakeNode.generate(spawn, count, table, direction)
		snake.can_move = false
		snake.on_die.connect(_on_die_snake)
		
		if count < modulations.size():
			snake.modulate = modulations[count]
		
		entities.add_child(snake)
		players[count] = snake
		count += 1

func pause() -> void:
	table.generate_food = false
	set_snake_move_status(false)

func resume() -> void:
	table.generate_food = true
	set_snake_move_status(true)

func _input(event: InputEvent) -> void:
	
	if ended:
		return
	
	if not started:
		if event.is_action_pressed("ui_accept"):
			resume()
			started = true
		
		return
	
	if event.is_action_pressed("pause"):
		pause()
		pause_menu.show()

func set_snake_move_status(to: bool) -> void:
	
	for id in players:
		
		var snake: SnakeNode = players.get(id)
		
		if snake:
			snake.can_move = to

func _process(_delta):
	
	if players.size() <= 1:
		ended = true
		pause()
		
		if players.size() == 0:
			win_menu.win(-1)
		else:
			win_menu.win(players[players.keys()[0]].player)
		
		return
	
	for id in players:
		var snake := players[id]
		
		for id2 in players:
			if id2 == id:
				continue
			
			var snake2 := players[id2]
			
			var snake_front = snake.body.front()
			
			if snake_front in snake2.body:
				
				if snake_front == snake2.body.front():
					
					var snake_size = snake.body.size()
					var snake2_size = snake2.body.size()
					
					if snake_size < snake2_size:
						snake.die()
					elif snake_size > snake2_size:
						snake2.die()
					else:
						snake.die()
						snake2.die()
				else:
					snake.die()

func _on_die_snake(id: int) -> void:
	players.erase(id)
