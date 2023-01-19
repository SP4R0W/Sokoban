extends Node2D


func _ready():
	Global.score = 0
	Global.time = 0
	Global.moves = 0
	Global.pushes = 0
	
	load_game_level()

func load_game_level():
	var path = "res://src/Levels/" + str(Global.level) + "/Level.tscn"

	var level = load(path).instance()
	level.connect("level_complete",self,"level_complete")
	add_child(level)
	
	$UI/CanvasLayer/TextureRect.show()
	$UI/CanvasLayer/LevelFinish.hide()
	
func level_complete():
	$Timer.stop()
	$UI/CanvasLayer/TextureRect.hide()
	
	$UI/CanvasLayer/LevelFinish.show()
	
	if (Global.level == 24):
		$UI/CanvasLayer/LevelFinish/Next_button.hide()
		$UI/CanvasLayer/LevelFinish/Menu_button2.show()
	else:
		$UI/CanvasLayer/LevelFinish/Menu_button2.hide()
		$UI/CanvasLayer/LevelFinish/Next_button.show()
	
func _on_Retry_button_pressed():
	Composer.goto_scene(Global.scene_paths["game"],true,true,0.2,0.2)

func _on_Menu_button_pressed():
	Composer.goto_scene(Global.scene_paths["level_select"],true,true,0.2,0.2)

func _on_Next_button_pressed():
	Global.level += 1
	
	Composer.goto_scene(Global.scene_paths["game"],true,true,0.2,0.2)
