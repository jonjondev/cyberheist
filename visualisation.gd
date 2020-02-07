extends Node2D

var relative_entity_pos = [null, 375, 200, 100, 50, 25, 0]
var relative_data_pos = [null, 400, 300, 175, 125, 100, 0]

func _physics_process(delta):
	var player_location = $"../Grid".player_loc
	var player_direction = $"../Grid".player_direction
	var secrets = $"../Grid".secrets
	var entities = $"../Grid".entities
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
		for location in entities.keys():
			map[location.y][location.x] = "x"
			
		for child in get_children():
			child.visible = false
		
		var wall_infront = false
		for i in range(7):
			var l_tile = get_tile(map, player_location, player_direction, i, 1)
			var f_tile = get_tile(map, player_location, player_direction, i, 0)
			var r_tile = get_tile(map, player_location, player_direction, i, -1)
			if l_tile == "■":
				get_node("l" + str(i)).visible = true
			if f_tile == "■":
				wall_infront = true
				get_node("f" + str(i)).visible = true
			elif f_tile == "*" and i > 0 and not $Data.visible and not wall_infront:
				$Data.z_index = 6-i
				$Data.scale = Vector2(5-i, 5-i)
				$Data.position.y = relative_data_pos[i]
				$Data.visible = true
			elif f_tile == "x" and i > 0 and not $Antivirus.visible and not wall_infront:
				var entity_loc = get_location(player_location, player_direction, i, 0)
				run_entity_animation(player_direction, entities[entity_loc])
				$Antivirus.z_index = 6-i
				$Antivirus.scale = Vector2(6-i, 6-i)
				$Antivirus.position.y = relative_entity_pos[i]
				$Antivirus.visible = true
			if r_tile == "■":
				get_node("r" + str(i)).visible = true
		
		$base.visible = true
		$ColorRect.visible = true
		
		$"../Minimap/TTD".text = "disconnect in: " + str($"../../ConsoleContainer/Console/RichTextLabel".ttd)

func run_entity_animation(player_direction, entity_direction):
	var new_animation = null
	var normalised_dir = player_direction - entity_direction
	if normalised_dir == 0:
		new_animation = "walk_backward"
	elif int(abs(normalised_dir)) == 2:
		new_animation = "walk_forward"
	elif normalised_dir == -1 or normalised_dir == 3:
		new_animation = "walk_right"
	elif normalised_dir == 1 or normalised_dir == -3:
		new_animation = "walk_left"
	if $Antivirus/AnimationPlayer.current_animation != new_animation:
		$Antivirus/AnimationPlayer.play(new_animation)

func get_location(location, direction, distance, offset):
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
	return Vector2(location.x + x_val, location.y + y_val)

func get_tile(map, location, direction, distance, offset):
	var final_loc = get_location(location, direction, distance, offset)
	if final_loc.y < map.size() and final_loc.y >= 0 and final_loc.x < map[0].size() and final_loc.x >= 0:
		return map[final_loc.y][final_loc.x]
