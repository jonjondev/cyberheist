extends Node2D

onready var console = $"../Console/RichTextLabel"
var minimised = true
onready var grid = $Grid

func _input(event):
	if not minimised and grid.wall_map:
		if Input.is_action_pressed('up'):
			move(+1)
		if Input.is_action_pressed('down'):
			move(-1)
		if Input.is_action_pressed('left'):
			grid.player_direction = (grid.player_direction - 1) % 4	
		if Input.is_action_pressed('right'):
			grid.player_direction = (grid.player_direction + 1) % 4
		if grid.player_direction < 0:
			grid.player_direction = 4 + grid.player_direction
	if Input.is_action_pressed("escape"):
		toggle_view()

func move(amount):
	var loc_temp = Vector2(grid.player_loc.x, grid.player_loc.y)
	match grid.player_direction:
		0:
			loc_temp.y -= amount
		1:
			loc_temp.x += amount
		2:
			loc_temp.y += amount
		3:
			loc_temp.x -= amount
	if $Grid.is_empty(loc_temp):
		grid.player_loc = loc_temp

func toggle_view():
	if minimised:
		$AnimationPlayer.play("maximise")
		console.awake = false
	else:
		$AnimationPlayer.play("minimise")
		console.awake = true
	minimised = not minimised
