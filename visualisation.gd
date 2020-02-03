extends Node2D

onready var walls = [
	preload("res://res/wall_near.png"),
	preload("res://res/wall_middle.png"),
	preload("res://res/wall_far.png"),
	preload("res://res/wall_very_far.png")
]

onready var lefts = [
	preload("res://res/left_near.png"),
	preload("res://res/left_middle.png"),
	preload("res://res/left_far.png"),
]

onready var rights = [
	preload("res://res/right_near.png"),
	preload("res://res/right_middle.png"),
	preload("res://res/right_far.png"),
]

func _physics_process(delta):
	var player_location = $"../Grid".player_loc
	var player_direction = $"../Grid".player_direction
	var secrets = $"../Grid".secrets
	var map = $"../Grid".wall_map
	
	if false:
		$Wall.visible = false
		$Left.visible = false
		$Right.visible = false
		for i in range(walls.size()):
			if get_tile(map, player_location, player_direction, i + 1, 0) == "■":
				$Wall.texture = walls[i]
				$Wall.visible = true
				for j in range(i, -1, -1):
					if get_tile(map, player_location, player_direction, j, 1) == "■":
						$Left.texture = lefts[j]
						$Left.visible = true
						break
				for j in range(i, -1, -1):
					if get_tile(map, player_location, player_direction, j, -1) == "■":
						$Right.texture = rights[j]
						$Right.visible = true
						break
				break
		var alert = $"../Minimap/Alert"
		alert.visible = false
		for location in secrets.keys():
			if location == player_location:
				alert.text = "memory found:\n" + secrets[location]
				alert.visible = true
		$"../Minimap/TTD".text = "disconnect in: " + str($"../../Console/RichTextLabel".ttd)
	
	for child in get_children():
		child.visible = false
	
	if map:
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
