@tool
extends PanelContainer

class_name ItemCellContainer

@onready var portrait: TextureRect = $Portrait

@export var portrait_sprite: Texture2D:
	set(value):
		
		portrait_sprite = value
		_update_textures()

func _ready():
	_update_textures()

func _update_textures():
	
	if portrait:
		if portrait_sprite:
			portrait.texture = portrait_sprite
