extends Node2D

func _physics_process(delta):
	var player_location = $"../Grid".player_loc
	var player_direction = $"../Grid".player_direction
	var secrets = $"../Grid".secrets
	var map = $"../Grid".wall_map
	
	if map:
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
			if r_tile == "■":
				get_node("r" + str(i)).visible = true
		
		var f6 = get_tile(map, player_location, player_direction, 6, 0)
		if f6 == "■":
				$f6.visible = true
		$base.visible = true
		$ColorRect.visible = true
	
		var alert = $"../Minimap/Alert"
		alert.visible = false
		for location in secrets.keys():
			if location == player_location:
				alert.text = "memory found:\n" + secrets[location]
				alert.visible = true
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
