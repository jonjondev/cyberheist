extends Node2D

onready var walls = [
	preload("res://res/wall_near.png"),
	preload("res://res/wall_middle.png"),
	preload("res://res/wall_far.png")
]

func _physics_process(delta):
	var player_location = get_parent().location
	var player_direction = get_parent().direction
	var map = $"../Grid".wall_map
	
	if player_direction == 0:
		if map[player_location.y-1][player_location.x] == "■":
			$Wall.texture = walls[0]
		elif map[player_location.y-2][player_location.x] == "■":
			$Wall.texture = walls[1]
		elif map[player_location.y-3][player_location.x] == "■":
			$Wall.texture = walls[2]