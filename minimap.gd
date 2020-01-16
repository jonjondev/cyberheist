extends RichTextLabel

onready var grid = $"../Grid"

var direction_chars = ["▲", "►", "▼", "◄"]

func _physics_process(delta):
	var temp_map = [["", "", "", "", ""],
					["", "", "", "", ""],
					["", "", "", "", ""],
					["", "", "", "", ""],
					["", "", "", "", ""]]
	
	var display_y = grid.player_loc.y - 2
	for i in range(5):
		display_y += 1
		var display_x = grid.player_loc.x - 2
		for j in range(5):
			display_x += 1
			if display_x > 0 and display_y > 0 and display_x < grid.wall_map[0].size() and display_y < grid.wall_map.size():
				if grid.wall_map[display_y - 1][display_x - 1] == "■":
					temp_map[i][j] = grid.wall_map[display_y - 1][display_x - 1]
				else:
					temp_map[i][j] = grid.entity_map[display_y - 1][display_x - 1]
			else:
				temp_map[i][j] = "■"
		
	temp_map[2][2] = direction_chars[grid.player_direction]
	
	var rows = []
	for i in range(temp_map.size()):
		for j in range(temp_map[i].size()):
			if direction_chars.has(temp_map[i][j]):
				temp_map[i][j] = "[color=fuchsia]" + temp_map[i][j] + "[/color]"
		rows.append(PoolStringArray(temp_map[i]).join(""))
	var flattened_map = PoolStringArray(rows).join("\n")
	
	bbcode_text = flattened_map