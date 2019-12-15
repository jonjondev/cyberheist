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
	match direction:
		0:
			location.y -= amount
		1:
			location.x += amount
		2:
			location.y += amount
		3:
			location.x -= amount