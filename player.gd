extends Node2D

var location = Vector2(1, 3)
var direction = 0

func _input(event):
	if Input.is_action_pressed('up'):
		move(+1)
	if Input.is_action_pressed('down'):
		move(-1)
	if Input.is_action_pressed('left'):
		direction = (direction - 1) % 4	
	if Input.is_action_pressed('right'):
		direction = (direction + 1) % 4
	if direction < 0:
		direction = 4 + direction

func move(amount):
	var loc_temp = Vector2(location.x, location.y)
	match direction:
		0:
			loc_temp.y -= amount
		1:
			loc_temp.x += amount
		2:
			loc_temp.y += amount
		3:
			loc_temp.x -= amount
	if $Grid.is_empty(loc_temp):
		location = loc_temp