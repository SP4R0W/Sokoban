extends Node2D


func _ready():
	randomize()
	load_level_folder()
	
	Composer.goto_scene(Global.scene_paths["mainmenu"],true,false,0.5,1)

func load_level_folder():
	var dir = Directory.new()
	var level_path = "user://levels"
	
	if (dir.open(level_path) == OK):
		print("Folder found")
	else:
		dir.make_dir_recursive(level_path)
