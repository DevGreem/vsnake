extends ProgressBar

class_name PropertyLimitBar

@export var property: StringName
var _getter := PropertyGetter.new()

func _process(_delta):
	
	var _value = _getter.process(owner.player, property)
	
	if !_value:
		return
	
	_value = _value as LimitedValue
	
	self.max_value = _value.max_value
	self.min_value = _value.min_value
	self.value = _value.current_value
	#print(_value.to_dict())
