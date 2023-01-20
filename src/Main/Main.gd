extends Node2D


func _ready():
	Global.button_click_sfx = $ButtonClick
	Global.menu_theme = $menuTheme
	
	randomize()

	Composer.goto_scene(Global.scene_paths["mainmenu"],true,false,0.5,1)
