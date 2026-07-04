extends Label

class_name PropertyLabel

@export var property: StringName
var _getter := PropertyGetter.new()

func _process(_delta):
	
	var _value = _getter.process(owner.player, property)
	
	if !_value:
		return
	
	if _value is Object:
		_value = _value.to_string()
		
	self.text = _value
