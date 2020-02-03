extends RichTextLabel

onready var grid = $"../Grid"

var direction_chars = ["▲", "►", "▼", "◄"]

func _physics_process(delta):
	if grid.wall_map:
		var merge_map = grid.wall_map.duplicate(true)
		
		for location in grid.entities.keys():
			merge_map[location.y][location.x] = grid.entities[location]
		
		var temp_map = [[" ", " ", " ", " ", " "],
						[" ", " ", " ", " ", " "],
						[" ", " ", " ", " ", " "],
						[" ", " ", " ", " ", " "],
						[" ", " ", " ", " ", " "],]
		
		var y_offset = -2
		for i in range(temp_map.size()):
			var x_offset = -2
			for j in range(temp_map[i].size()):
				var y_index = grid.player_loc.y+y_offset
				var x_index = grid.player_loc.x+x_offset
				if  y_index < merge_map.size() and y_index >= 0 and x_index < merge_map[y_index].size() and x_index >= 0:
					temp_map[i][j] = merge_map[y_index][x_index]
				else:
					temp_map[i][j] = "■"
				x_offset += 1
			y_offset += 1
		
		temp_map[2][2] = direction_chars[grid.player_direction]
		
		var rows = []
		for i in range(temp_map.size()):
			for j in range(temp_map[i].size()):
				if direction_chars.has(temp_map[i][j]):
					temp_map[i][j] = "[color=fuchsia]" + temp_map[i][j] + "[/color]"
				elif temp_map[i][j] == 'x':
					temp_map[i][j] = "[color=red]" + temp_map[i][j] + "[/color]"
			rows.append(PoolStringArray(temp_map[i]).join(""))
		var flattened_map = PoolStringArray(rows).join("\n")
		
		bbcode_text = flattened_map
