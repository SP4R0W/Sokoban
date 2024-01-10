extends Node2D


func _ready():
	Global.button_click_sfx = $ButtonClick
	Global.menu_theme = $menuTheme

	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear2db(Global.music_vol/100))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),linear2db(Global.sfx_vol/100))

	randomize()

	Composer.goto_scene(Global.scene_paths["mainmenu"],true,false,0.5,1)
