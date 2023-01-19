extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Menu")


func _on_Play_button_pressed():
	Composer.goto_scene(Global.scene_paths["level_select"],true,true,0.5,0.5)


func _on_Exit_button_pressed():
	get_tree().quit()

func _unhandled_input(event):
	if (event is InputEventMouseButton):
		if (event.is_pressed() && event.button_index == BUTTON_LEFT):
			$AnimationPlayer.advance(1.4)
			$AnimationPlayer.stop()
