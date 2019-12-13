extends Node2D

var player_loc = Vector2(0, 0)
var player_direction = 0

var direction_chars = ["▲", "▼", "◄", "►"]

var wall_map  = [
["■", "■", "■", "■"],
["■", " ", " ", "■"],
["■", " ", "■", "■"],
["■", " ", "■", "■"],
["■", "■", "■", "■"],
]

var entity_map  = [
[" ", " ", " ", " "],
[" ", " ", " ", " "],
[" ", " ", " ", " "],
[" ", " ", " ", " "],
[" ", " ", " ", " "],
]

func _ready():
	player_loc = get_parent().location
	player_direction = get_parent().direction

func _physics_process(delta):
	var wall_rows = []
	var entity_rows = []
	for i in range(wall_map.size()):
		if i == player_loc.y:
			entity_map[i][player_loc.x] = direction_chars[player_direction]
		wall_rows.append(PoolStringArray(wall_map[i]).join(""))
		entity_rows.append(PoolStringArray(entity_map[i]).join(""))
	var flattened_wall_map = PoolStringArray(wall_rows).join("\n")
	var flattened_entity_map = PoolStringArray(entity_rows).join("\n")
	
	$Map.text = flattened_wall_map
	$Player.text = flattened_entity_map