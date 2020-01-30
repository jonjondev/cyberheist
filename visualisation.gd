extends Node2D

onready var walls = [
	preload("res://res/wall_near.png"),
	preload("res://res/wall_middle.png"),
	preload("res://res/wall_far.png"),
	#preload("res://res/wall_very_far.png")
]

onready var lefts = [
	preload("res://res/left_near.png"),
	preload("res://res/left_middle.png"),
	preload("res://res/left_far.png"),
]

onready var rights = [
	preload("res://res/right_near.png"),
	preload("res://res/right_middle.png"),
	preload("res://res/right_far.png"),
]

func _physics_process(delta):
	var player_location = get_parent().location
	var player_direction = get_parent().direction
	var map = $"../Grid".wall_map
	
	$Wall.visible = false
	$Left.visible = false
	$Right.visible = false
	for i in range(walls.size()):
		if get_tile(map, player_location, player_direction, i + 1, 0) == "■":
			$Wall.texture = walls[i]
			$Wall.visible = true
			for j in range(i, -1, -1):
				if get_tile(map, player_location, player_direction, j, 1) == "■":
					$Left.texture = lefts[j]
					$Left.visible = true
					break
			for j in range(i, -1, -1):
				if get_tile(map, player_location, player_direction, j, -1) == "■":
					$Right.texture = rights[j]
					$Right.visible = true
					break
			break


func get_tile(map, location, direction, distance, offset):
	match direction:
		0:
			return map[location.y - distance][location.x -offset]
		1:
			return map[location.y -offset][location.x + distance]
		2:
			return map[location.y + distance][location.x + offset]
		3:
			return map[location.y + offset][location.x - distance]
