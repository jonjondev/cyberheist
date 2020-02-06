extends Node2D

var player_loc = null
var player_direction = null
var secrets = null

var wall_map = null

var entities = null

onready var ticker = $"../Timer"

func _ready():
	$"../Timer".connect("timeout", self, "move_entities")

func move_entities():
	if entities:
		for entity_loc in entities.keys():
			var temp_dir = entities[entity_loc]
			var temp_loc = move(entity_loc, temp_dir, 1)
			entities.erase(entity_loc)
			if is_empty(temp_loc):
				entities[temp_loc] = temp_dir
			else:
				temp_dir = flip_dir(temp_dir)
				entities[move(entity_loc, flip_dir(temp_dir), 1)] = temp_dir

func is_empty(location):
	return wall_map[location.y][location.x] == " "

func set_simulation(memory):
	wall_map = memory['wall_map']
	entities = memory['entities']
	player_loc = memory['player_loc']
	player_direction = memory['player_dir']
	secrets = memory['secrets']

func move(entity_loc, direction, amount):
	var loc_temp = Vector2(entity_loc.x, entity_loc.y)
	match direction:
		0:
			loc_temp.y -= amount
		1:
			loc_temp.x += amount
		2:
			loc_temp.y += amount
		3:
			loc_temp.x -= amount
	return loc_temp

func flip_dir(direction):
	var new_dir
	match direction:
		0:
			new_dir = 2
		1:
			new_dir = 3
		2:
			new_dir = 0
		3:
			new_dir = 1
	return new_dir
