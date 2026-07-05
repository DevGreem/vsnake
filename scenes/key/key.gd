@tool
extends Panel

@export var label: Label

@export var key: Key:
	set(value):
		
		key = value
		
		if key:
			write_key(key)

func write_key(_key: Key) -> void:
	
	if _key == -1:
		label.text = ""
		return
	
	label.text = OS.get_keycode_string(key)
	var font := label.get_theme_font("font")
	var font_size := label.get_theme_font_size("font_size")
	
	while font.get_string_size(label.text, HORIZONTAL_ALIGNMENT_CENTER, -1, font_size).x > 100:
		font_size -= 1
	
	
	label.add_theme_font_size_override("font_size", font_size)
