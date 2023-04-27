extends AnimatedSprite

export var ray_length: int = 64

onready var tween = $Tween
onready var ray = $RayCast2D

var moves: Array = []
var history_moves: Array = []

var is_moving: bool = false

var has_pushed: bool = false
var box = null

var can_move = true

const PREVIOUS_MOVES_LIMIT = 50

func _ready():
	pass

func _physics_process(delta):
	if (!can_move):
		return

	# Append the moves to an array for queuing moves.

	if (Input.is_action_just_pressed("up")):
		moves.append("up")

	if (Input.is_action_just_pressed("down")):
		moves.append("down")

	if (Input.is_action_just_pressed("left")):
		moves.append("left")

	if (Input.is_action_just_pressed("right")):
		moves.append("right")

	if (Input.is_action_just_pressed("back")):
		execute_past_move()

	if (Input.is_action_just_pressed("reset")):
		Composer.goto_scene(Global.scene_paths["game"],true,true,0.2,0.2)

	if (moves.size() > 0 && !is_moving):
		execute_move() # This function executes the current move

func check_for_collision(dir: String) -> bool:
	if (ray.is_colliding()):
		var collider: Node = ray.get_collider()
		if (collider.is_in_group("walls")):
			has_pushed = false
			box = null
			return false
		elif (collider.is_in_group("boxes")):
			if (!collider.check_for_move(dir)):
				has_pushed = false
				box = null
				return false
			else:
				has_pushed = true
				box = collider
	else:
		has_pushed = false
		box = null

	return true

func add_move(move):
	# Note that the bigger the previous moves array will be, the slower this will run.
	if (typeof(move) == TYPE_STRING):
		history_moves.push_front(move)
	else:
		history_moves.insert(1,move)

	if (history_moves.size() > PREVIOUS_MOVES_LIMIT):
		history_moves.pop_back()

func execute_past_move():
	if (history_moves.size() < 1 || is_moving):
		return

	is_moving = true

	# Take the latest move from the list (first one in this case)
	var move = history_moves[0]
	var has_pushed: bool = false

	# Move in the previous direction
	match move:
		"up":
			animation = "down_idle"
			ray.cast_to = Vector2(0,ray_length)
			ray.force_raycast_update()
			tween.interpolate_property(self,"global_position:y",global_position.y,global_position.y+128,0.2)
		"down":
			animation = "up_idle"
			ray.cast_to = Vector2(0,-ray_length)
			ray.force_raycast_update()
			tween.interpolate_property(self,"global_position:y",global_position.y,global_position.y-128,0.2)
		"left":
			animation = "right_idle"
			ray.cast_to = Vector2(ray_length,0)
			ray.force_raycast_update()
			tween.interpolate_property(self,"global_position:x",global_position.x,global_position.x+128,0.2)
		"right":
			animation = "left_idle"
			ray.cast_to = Vector2(-ray_length,0)
			ray.force_raycast_update()
			tween.interpolate_property(self,"global_position:x",global_position.x,global_position.x-128,0.2)

	Global.moves -= 1

	tween.start()
	$Walk.play()

	if (history_moves.size() > 1):
		# An array in the next index indicated that a box has been pushed.
		if (typeof(history_moves[1]) == TYPE_ARRAY):
			history_moves[1][1].exec_past_move(history_moves[1][0])
			has_pushed = true
			Global.pushes -= 1

	history_moves.pop_front()
	if (has_pushed):
		history_moves.pop_front()

	yield(tween,"tween_all_completed")

	is_moving = false


func execute_move():
	is_moving = true

	# Execute the first move in the list.
	var move = moves[0]

	# Check if the player's ray collides with anything
	# If yes, then move; If there's a box move it as well
	# If no, then abort
	match move:
		"up":
			animation = "up_idle"
			ray.cast_to = Vector2(0,-ray_length)
			ray.force_raycast_update()
			if (check_for_collision(move) != false):
				tween.interpolate_property(self,"global_position:y",global_position.y,global_position.y-128,0.2)
				Global.moves += 1
				add_move(move)
				if (has_pushed):
					add_move([move,box])
		"down":
			animation = "down_idle"
			ray.cast_to = Vector2(0,ray_length)
			ray.force_raycast_update()
			if (check_for_collision(move) != false):
				tween.interpolate_property(self,"global_position:y",global_position.y,global_position.y+128,0.2)
				Global.moves += 1
				add_move(move)
				if (has_pushed):
					add_move([move,box])
		"left":
			animation = "left_idle"
			ray.cast_to = Vector2(-ray_length,0)
			ray.force_raycast_update()
			if (check_for_collision(move) != false):
				tween.interpolate_property(self,"global_position:x",global_position.x,global_position.x-128,0.2)
				Global.moves += 1
				add_move(move)
				if (has_pushed):
					add_move([move,box])
		"right":
			animation = "right_idle"
			ray.cast_to = Vector2(ray_length,0)
			ray.force_raycast_update()
			if (check_for_collision(move) != false):
				tween.interpolate_property(self,"global_position:x",global_position.x,global_position.x+128,0.2)
				Global.moves += 1
				add_move(move)
				if (has_pushed):
					add_move([move,box])

	tween.start()
	$Walk.play()

	yield(tween,"tween_all_completed")

	moves.pop_front()
	is_moving = false


func _on_Area2D_area_entered(area):
	if (area.is_in_group("coins")):
		area.score()
		$Coin.play()
