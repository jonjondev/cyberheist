extends Node2D

var player_loc = Vector2(0, 0)
var player_direction = 0

var wall_map = [
["■", "■", "■", "■"],
["■", " ", " ", "■"],
["■", " ", "■", "■"],
["■", " ", "■", "■"],
["■", "■", "■", "■"],
]

var entity_map = [
[" ", " ", " ", " "],
[" ", " ", " ", " "],
[" ", " ", " ", " "],
[" ", " ", " ", " "],
[" ", " ", " ", " "],
]

func _physics_process(delta):
	player_loc = get_parent().location
	player_direction = get_parent().direction

func can_move(location):
	return wall_map[location.y][location.x] == " "