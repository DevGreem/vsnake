extends TextureRect

class_name MoodPortraitNode

@export var property: StringName
var _getter := PropertyGetter.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	var _value: Texture2D = _getter.process(owner.player, property)
	
	if !_value:
		return
	
	self.texture = _value
