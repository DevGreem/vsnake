extends Resource

class_name ProjectPaths

@export var _dir_list: Array[DirData] = []
@export var _file_list: Array[FileData] = []

## Key: Name of the path
## Value: Route of the path
## Example: { 'entities' : 'res://content/entities' }
var _dirs: Dictionary[String, String] = {}
var _files: Dictionary[String, String] = {}

func initialize():
	
	for item in _dir_list:
		_dirs[item.name] = item.dir
	
	for item in _file_list:
		_files[item.name] = item.path

func get_dir(name: String) -> String:
	return _dirs.get(name)

func get_file(name: String) -> String:
	return _files.get(name)
