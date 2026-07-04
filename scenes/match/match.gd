extends Node2D

class_name MatchNode

@export var _time_per_turn := 1.0
var current_time: float
@export var entities: Node

func _ready():
	current_time = _time_per_turn

func _process(delta: float) -> void:
	
	current_time -= delta
	
	if current_time <= 0:
		for entity in entities.get_children():
			
			if entity is SnakeNode:
				entity.update_body()
		
		current_time = _time_per_turn
