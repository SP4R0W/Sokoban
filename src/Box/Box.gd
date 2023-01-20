tool
extends Area2D

onready var tween = $Tween
onready var ray = $RayCast2D

var secures: Array = []

export(String, "1", "2", "3", "4", "5") var box_type = "1"

signal box_secure(box)
signal box_remove(box)

func _ready():
	$AnimatedSprite.animation = box_type

func can_move() -> bool:
	if (ray.is_colliding()):
		var collider: Node = ray.get_collider()
		if (collider.is_in_group("walls")):
			return false
		elif (collider.is_in_group("boxes")):
			return false
			
	return true

func check_for_move(dir: String) -> bool:
	match dir:
		"up":
			ray.cast_to = Vector2(0,-64)
			ray.force_raycast_update()
			if (can_move()):
				Global.pushes += 1
				tween.interpolate_property(self,"global_position:y",global_position.y,global_position.y-128,0.2)
				tween.start()
				return true
		"down":
			ray.cast_to = Vector2(0,64)
			ray.force_raycast_update()
			if (can_move()):
				Global.pushes += 1
				tween.interpolate_property(self,"global_position:y",global_position.y,global_position.y+128,0.2)
				tween.start()
				return true
		"left":
			ray.cast_to = Vector2(-64,0)
			ray.force_raycast_update()
			if (can_move()):
				Global.pushes += 1
				tween.interpolate_property(self,"global_position:x",global_position.x,global_position.x-128,0.2)
				tween.start()
				return true
		"right":
			ray.cast_to = Vector2(64,0)
			ray.force_raycast_update()
			if (can_move()):
				Global.pushes += 1
				tween.interpolate_property(self,"global_position:x",global_position.x,global_position.x+128,0.2)
				tween.start()
				return true
	
	return false

func exec_past_move(dir: String):
	match dir:
		"up":
			ray.cast_to = Vector2(0,64)
			ray.force_raycast_update()
			tween.interpolate_property(self,"global_position:y",global_position.y,global_position.y+128,0.2)
		"down":
			ray.cast_to = Vector2(0,-64)
			ray.force_raycast_update()
			tween.interpolate_property(self,"global_position:y",global_position.y,global_position.y-128,0.2)
		"left":
			ray.cast_to = Vector2(64,0)
			ray.force_raycast_update()
			tween.interpolate_property(self,"global_position:x",global_position.x,global_position.x+128,0.2)
		"right":
			ray.cast_to = Vector2(-64,0)
			ray.force_raycast_update()
			tween.interpolate_property(self,"global_position:x",global_position.x,global_position.x-128,0.2)
	
	tween.start()
	
func check_secure():
	print(secures)
	
	if (secures.size() == 0):
		$AnimatedSprite.modulate = Color(1,1,1,1)
		emit_signal("box_remove",self)
		return
	
	for secure in secures:
		if (secure.get_node("AnimatedSprite").animation == $AnimatedSprite.animation):
			$AnimatedSprite.modulate = Color(0,1,0,1)
			emit_signal("box_secure",self)
			$Secure.play()
			break
		else:
			$AnimatedSprite.modulate = Color(1,1,1,1)
			emit_signal("box_remove",self)

func _on_Box_area_entered(area):
	if (area.is_in_group("secure")):
		if (!secures.has(area)):
			secures.append(area)
			
			check_secure()


func _on_Box_area_exited(area):
	if (area.is_in_group("secure")):
		if (secures.has(area)):
			secures.erase(area)
			
			check_secure()
