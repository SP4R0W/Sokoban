extends Control

func _ready():
	$CanvasLayer/TextureRect/VBoxContainer/Level.text = "Level: " + str(Global.level)

func _process(delta):
	$CanvasLayer/TextureRect/VBoxContainer/Score.text = "Score: " + str(Global.score)
	$CanvasLayer/TextureRect/VBoxContainer/Moves.text = "Moves: " + str(Global.moves)
	$CanvasLayer/TextureRect/VBoxContainer/Pushes.text = "Pushes: " + str(Global.pushes)
	
	$CanvasLayer/LevelFinish/VBoxContainer/Score.text = "Score: " + str(Global.score)
	$CanvasLayer/LevelFinish/VBoxContainer/Moves.text = "Moves: " + str(Global.moves)
	$CanvasLayer/LevelFinish/VBoxContainer/Pushes.text = "Pushes: " + str(Global.pushes)

func _on_Timer_timeout():
	Global.time += 1
	$CanvasLayer/TextureRect/VBoxContainer/Time.text = "Time: " + str(Global.time)
	$CanvasLayer/LevelFinish/VBoxContainer/Time.text = "Time: " + str(Global.time)
