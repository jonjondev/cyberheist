extends Node2D

onready var grid = get_parent().get_node("Grid")

var direction_chars = ["▲", "►", "▼", "◄"]

func _physics_process(delta):
	var temp_entity_map = grid.entity_map.duplicate(true)
	
	var wall_rows = []
	var entity_rows = []
	for i in range(grid.wall_map.size()):
		if i == grid.player_loc.y:
			temp_entity_map[i][grid.player_loc.x] = direction_chars[grid.player_direction]
		wall_rows.append(PoolStringArray(grid.wall_map[i]).join(""))
		entity_rows.append(PoolStringArray(temp_entity_map[i]).join(""))
	var flattened_wall_map = PoolStringArray(wall_rows).join("\n")
	var flattened_entity_map = PoolStringArray(entity_rows).join("\n")
	
	$Map.text = flattened_wall_map
	$Player.text = flattened_entity_map