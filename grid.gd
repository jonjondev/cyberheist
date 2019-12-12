extends Node2D

var player_loc = Vector2(1, 3)
var player_direction = 0

var direction_chars = ["▲", "▼", "◄", "►"]

var map  = [
["■", "■", "■", "■"],
["■", " ", " ", "■"],
["■", " ", "■", "■"],
["■", " ", "■", "■"],
["■", "■", "■", "■"],
]

func _physics_process(delta):
	var rows = []
	for i in range(map.size()):
		if i == player_loc.y:
			map[i][player_loc.x] = direction_chars[player_direction]
		rows.append(PoolStringArray(map[i]).join(""))
	var wall_map = PoolStringArray(rows).join("\n")
	
	#for i in range(wall_map.length()):
		#if wall_map[i] != ""
	
	$Map.text = wall_map