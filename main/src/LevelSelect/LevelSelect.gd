extends Node2D


func _ready():
	$AnimationPlayer.play("LevelSelect")

	for button in $Control/CanvasLayer/LevelContainer.get_children():
		button.connect("level_select",self,"set_level")

	if (!Global.menu_theme.playing):
		Global.menu_theme.play()

func set_level(id: int):
	# Set the level to the LevelButton's id
	Global.level = id
	Composer.goto_scene(Global.scene_paths["game"],true,true,0.5,0.5)

func _on_Menu_button_pressed():
	Composer.goto_scene(Global.scene_paths["mainmenu"],true,true,0.5,0.5)

func _unhandled_input(event):
	if (event is InputEventMouseButton):
		if (event.is_pressed() && event.button_index == BUTTON_LEFT):
			# Skip the animation
			$AnimationPlayer.advance(3)
			$AnimationPlayer.stop()
