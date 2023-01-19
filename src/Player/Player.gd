extends AnimatedSprite

export var ray_length: int = 64

onready var tween = $Tween
onready var ray = $RayCast2D

var moves: Array = []

var is_moving: bool = false

var can_move = true

func _ready():
	pass

func _physics_process(delta):
	if (!can_move):
		return
	
	if (Input.is_action_just_pressed("up")):
		moves.append("up")

	if (Input.is_action_just_pressed("down")):
		moves.append("down")

	if (Input.is_action_just_pressed("left")):
		moves.append("left")
		
	if (Input.is_action_just_pressed("right")):
		moves.append("right")
		
	if (Input.is_action_just_pressed("reset")):
			Composer.goto_scene(Global.scene_paths["game"],true,true,0.2,0.2)

	if (moves.size() > 0 && !is_moving):
		execute_move()
		
func check_for_collision(dir: String) -> bool:
	if (ray.is_colliding()):
		var collider: Node = ray.get_collider()
		if (collider.is_in_group("walls")):
			return false
		elif (collider.is_in_group("boxes")):
			if (!collider.check_for_move(dir)):
				return false

	return true
		
func execute_move():
	is_moving = true
	
	var move = moves[0]
	
	match move:
		"up":
			animation = "up_idle"
			ray.cast_to = Vector2(0,-ray_length)
			ray.force_raycast_update()
			if (check_for_collision(move) != false):
				tween.interpolate_property(self,"global_position:y",global_position.y,global_position.y-128,0.2)
				Global.moves += 1
		"down":
			animation = "down_idle"
			ray.cast_to = Vector2(0,ray_length)
			ray.force_raycast_update()
			if (check_for_collision(move) != false):
				tween.interpolate_property(self,"global_position:y",global_position.y,global_position.y+128,0.2)
				Global.moves += 1
		"left":
			animation = "left_idle"
			ray.cast_to = Vector2(-ray_length,0)
			ray.force_raycast_update()
			if (check_for_collision(move) != false):
				tween.interpolate_property(self,"global_position:x",global_position.x,global_position.x-128,0.2)
				Global.moves += 1
		"right":
			animation = "right_idle"
			ray.cast_to = Vector2(ray_length,0)
			ray.force_raycast_update()
			if (check_for_collision(move) != false):
				tween.interpolate_property(self,"global_position:x",global_position.x,global_position.x+128,0.2)
				Global.moves += 1
			
	tween.start()
	
	yield(tween,"tween_all_completed")
	
	moves.pop_front()
	is_moving = false


func _on_Area2D_area_entered(area):
	if (area.is_in_group("coins")):
		area.score()
