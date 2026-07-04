extends RefCounted

class_name PropertyGetter

func process(node: Variant, property: StringName) -> Variant:
	
	if not node:
		return
	
	if not property:
		return
		
	var names := property.split(".")
	var last = node
	
	for val in names:
		last = last.get(val)
	
	return last
