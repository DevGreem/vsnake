extends Button

## Packed Scene (Only fill if you don't need recursion betweem scenes)
@export var scene: PackedScene
## Path to the scene (Only fill if you need recursion between scenes)
@export_file("*.tscn") var scene_dir: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	
	if scene_dir:
		get_tree().change_scene_to_file(scene_dir)
	elif scene:
		get_tree().change_scene_to_packed(scene)
