extends Node2D


func _ready():
	Global.button_click_sfx = $ButtonClick
	Global.menu_theme = $menuTheme
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),Global.music_vol)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),Global.sfx_vol)	
	
	randomize()

	Composer.goto_scene(Global.scene_paths["mainmenu"],true,false,0.5,1)
