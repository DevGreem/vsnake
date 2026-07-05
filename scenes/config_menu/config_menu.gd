extends Control

@onready var options: VBoxContainer = $"Options"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for i in range(GameConfig.config.controls.size()):
		var config := GameConfig.config.controls[i];
		
		var hbox := VBoxContainer.new()
		var section_title := Label.new()
		section_title.name = "SectionTitle"
		section_title.text = "Player " + str(i+1)
		
		hbox.add_child(section_title)
		options.add_child(hbox)
		
		for key: Key in config:
			var direction: SnakeNode.Direction = config[key]
			
			var container: LabeledButton = preload("res://components/nodes/controls/containers/h_box_container/labeled_button.tscn").instantiate()
			
			hbox.add_child(container)
			
			container.label.text = SnakeNode.direction_to_string(direction).capitalize()
			container.button.text = OS.get_keycode_string(key)
			container.button.set_script(preload("res://components/nodes/controls/buttons/key_detector.gd"))
			container.button.initialize()
