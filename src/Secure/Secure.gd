extends Area2D

export(String, "1", "2", "3", "4", "5") var secure_type = "1"

func _ready():
	$AnimatedSprite.animation = secure_type
