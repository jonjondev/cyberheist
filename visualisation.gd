extends Node2D

onready var walls = [
	preload("res://res/wall_near.png"),
	preload("res://res/wall_middle.png"),
	preload("res://res/wall_far.png"),
	preload("res://res/wall_very_far.png")
]

func _physics_process(delta):
	var player_location = get_parent().location
	var player_direction = get_parent().direction
	var map = $"../Grid".wall_map
	
	$Wall.visible = false
	for i in range(walls.size()):
		if get_tile(map, player_location, player_direction, i + 1) == "■":
			$Wall.texture = walls[i]
			$Wall.visible = true
			break

func get_tile(map, location, direction, distance):
	match direction:
		0:
			return map[location.y - distance][location.x]