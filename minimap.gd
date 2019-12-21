extends RichTextLabel

onready var grid = get_parent().get_node("Grid")

var direction_chars = ["▲", "►", "▼", "◄"]

func _physics_process(delta):
	var temp_map = grid.wall_map.duplicate(true)
	
	for i in range(temp_map.size()):
		for j in range(temp_map[i].size()):
			if temp_map[i][j] != "■":
				temp_map[i][j] = grid.entity_map[i][j]
	
	var rows = []
	for i in range(temp_map.size()):
		if i == grid.player_loc.y:
			temp_map[i][grid.player_loc.x] = direction_chars[grid.player_direction]
		for j in range(temp_map[i].size()):
			if direction_chars.has(temp_map[i][j]):
				temp_map[i][j] = "[color=fuchsia]" + temp_map[i][j] + "[/color]"
		rows.append(PoolStringArray(temp_map[i]).join(""))
	var flattened_map = PoolStringArray(rows).join("\n")
	
	bbcode_text = flattened_map