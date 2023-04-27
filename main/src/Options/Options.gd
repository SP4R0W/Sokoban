extends Node2D


func _ready():
	$AnimationPlayer.play("Options")

	$Control/CanvasLayer/Music/Label.text = "Music " + str(Global.music_vol)
	$Control/CanvasLayer/SFX/Label.text = "SFX: " + str(Global.sfx_vol)

	$Control/CanvasLayer/Music/MusicSlider.value = Global.music_vol
	$Control/CanvasLayer/SFX/SFXSlider.value = Global.sfx_vol

func _on_Exit_button_pressed():
	Composer.goto_scene(Global.scene_paths["mainmenu"],true,true,0.5,0.5)

func _unhandled_input(event):
	if (event is InputEventMouseButton):
		if (event.is_pressed() && event.button_index == BUTTON_LEFT):
			# Skip the animation
			$AnimationPlayer.advance(1)
			$AnimationPlayer.stop()


func _on_MusicSlider_drag_ended(value_changed):
	if (value_changed):
		Global.music_vol = $Control/CanvasLayer/Music/MusicSlider.value
		$Control/CanvasLayer/Music/Label.text = "Music " + str(Global.music_vol)

		# Set the volume for Music
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),Global.music_vol)

func _on_SFXSlider_drag_ended(value_changed):
	if (value_changed):
		Global.sfx_vol = $Control/CanvasLayer/SFX/SFXSlider.value
		$Control/CanvasLayer/SFX/Label.text = "SFX: " + str(Global.sfx_vol)

		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),Global.sfx_vol)
