extends Node

const PATH := "user://config.tres"
var config: PlayersConfig

func _ready():
	
	if not FileAccess.file_exists(PATH):
		ResourceSaver.save(PlayersConfig.new(), PATH)
	
	print(ProjectSettings.globalize_path(PATH))
	config = ResourceLoader.load(PATH)
