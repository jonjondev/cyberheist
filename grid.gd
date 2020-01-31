extends Node2D

var player_loc = Vector2(1, 3)
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
[" ", "x", " ", " "],
[" ", " ", " ", " "],
[" ", " ", " ", " "],
[" ", " ", " ", " "],
]

func is_empty(location):
	return wall_map[location.y][location.x] == " "
