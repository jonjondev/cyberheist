extends Node2D

func _physics_process(delta):
	var player_location = $"../Grid".player_loc
	var player_direction = $"../Grid".player_direction
	var secrets = $"../Grid".secrets
	var map = $"../Grid".wall_map
	
	if map:
		map = $"../Grid".wall_map.duplicate(true)
		var alert = $"../Minimap/Alert"
		alert.visible = false
		for location in secrets.keys():
			map[location.y][location.x] = "*"
			if location == player_location:
				alert.text = "memory found:\n" + secrets[location]
				alert.visible = true
			
		for child in get_children():
			child.visible = false
		
		for i in range(6):
			var l_tile = get_tile(map, player_location, player_direction, i, 1)
			var f_tile = get_tile(map, player_location, player_direction, i, 0)
			var r_tile = get_tile(map, player_location, player_direction, i, -1)
			if l_tile == "■":
				get_node("l" + str(i)).visible = true
			if f_tile == "■":
				get_node("f" + str(i)).visible = true
			elif f_tile == "*" and i > 0 and not $retro_file.visible:
				$retro_file.scale = Vector2(5-i, 5-i)
				$retro_file.visible = true
			if r_tile == "■":
				get_node("r" + str(i)).visible = true
		
		var f6 = get_tile(map, player_location, player_direction, 6, 0)
		if f6 == "■":
				$f6.visible = true
		$base.visible = true
		$ColorRect.visible = true
		
		$"../Minimap/TTD".text = "disconnect in: " + str($"../../Console/RichTextLabel".ttd)


func get_tile(map, location, direction, distance, offset):
	var y_val
	var x_val
	match direction:
		0:
			y_val = -distance
			x_val = -offset
		1:
			y_val = -offset
			x_val = distance
		2:
			y_val = distance
			x_val = offset
		3:
			y_val = offset
			x_val = -distance
	
	var final_y = location.y + y_val
	var final_x = location.x + x_val
	
	if final_y < map.size() and final_y >= 0 and final_x < map[0].size() and final_x >= 0:
		return map[final_y][final_x]
