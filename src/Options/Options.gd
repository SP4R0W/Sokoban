extends Node2D


func _ready():
	$AnimationPlayer.play("Options")
	$Control/CanvasLayer/Music/Label.text = "Music " + str(Global.music_vol)
	$Control/CanvasLayer/SFX/Label.text = "SFX: " + str(Global.sfx_vol)
	$Control/CanvasLayer/Music/MusicSlider.value = Global.music_vol
	$Control/CanvasLayer/SFX/SFXSlider.value = Global.sfx_vol

func _on_Exit_button_pressed():
	Global.button_click_sfx.play()
	
	Composer.goto_scene(Global.scene_paths["mainmenu"],true,true,0.5,0.5)
	
func _unhandled_input(event):
	if (event is InputEventMouseButton):
		if (event.is_pressed() && event.button_index == BUTTON_LEFT):
			$AnimationPlayer.advance(1)
			$AnimationPlayer.stop()


func _on_MusicSlider_drag_ended(value_changed):
	if (value_changed):
		Global.music_vol = $Control/CanvasLayer/Music/MusicSlider.value
		$Control/CanvasLayer/Music/Label.text = "Music " + str(Global.music_vol)
		
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),Global.music_vol)

func _on_SFXSlider_drag_ended(value_changed):
	if (value_changed):
		Global.sfx_vol = $Control/CanvasLayer/SFX/SFXSlider.value
		$Control/CanvasLayer/SFX/Label.text = "SFX: " + str(Global.sfx_vol)
		
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),Global.sfx_vol)

func _on_OptionButton_item_selected(index):
	if (index != -1):
		var res_text = $Control/CanvasLayer/Resolution/OptionButton.get_item_text(index).split("x")
		var new_res = Vector2(int(res_text[0]),int(res_text[1]))
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,SceneTree.STRETCH_ASPECT_KEEP,new_res)
		OS.set_window_size(new_res)
