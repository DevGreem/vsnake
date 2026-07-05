extends Node2D

class_name MatchNode

@export var entities: Node
var ended := false

var players: Dictionary[int, SnakeNode] = {}
@onready var table: TableNode = $"Map/Table"

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
		
		if event.is_action_pressed("ui_accept"):
			get_tree().change_scene_to_packed(load("res://scenes/main/main.tscn"))
			return
	
	if event.is_action_pressed("ui_accept"):
		resume()
	
	if event.is_action_pressed("pause"):
		pause()

func set_snake_move_status(to: bool) -> void:
	
	for id in players:
		
		var snake: SnakeNode = players.get(id)
		
		if snake:
			snake.can_move = to

func _process(_delta):
	
	if players.size() <= 1:
		ended = true
		pause()
	
	for id in players:
		var snake := players[id]
		
		for id2 in players:
			if id2 == id:
				continue
			
			var snake2 := players[id2]
			
			if snake.body.front() in snake2.body:
				snake.die()

func _on_die_snake(id: int) -> void:
	players.erase(id)
