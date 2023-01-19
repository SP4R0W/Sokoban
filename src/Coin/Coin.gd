extends Area2D


func _ready():
	$AnimationPlayer.play("Rotate")

func score():
	Global.score += 100
	queue_free()
