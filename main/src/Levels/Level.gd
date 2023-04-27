extends Node2D

var boxes: Dictionary = {}

signal level_complete()

func _ready():
	for box in $Boxes.get_children():
		boxes[box] = false
		box.connect("box_secure",self,"secure_box")
		box.connect("box_remove",self,"unsecure_box")

func secure_box(box):
	boxes[box] = true
	if (!boxes.values().has(false)):
		$Player.can_move = false

		yield(get_tree().create_timer(0.5),"timeout")

		emit_signal("level_complete")

		$Player.queue_free()

func unsecure_box(box):
	boxes[box] = false
