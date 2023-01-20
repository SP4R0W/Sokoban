extends Node2D


func _ready():
	$AnimationPlayer.play("Credits")
	
func _on_Exit_button_pressed():
	Global.button_click_sfx.play()
	Composer.goto_scene(Global.scene_paths["mainmenu"],true,true,0.5,0.5)

func _unhandled_input(event):
	if (event is InputEventMouseButton):
		if (event.is_pressed() && event.button_index == BUTTON_LEFT):
			$AnimationPlayer.advance(1)
			$AnimationPlayer.stop()
