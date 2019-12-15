extends Node2D

var location = Vector2(1, 3)
var direction = 0

func _input(event):
	if Input.is_action_pressed('up'):
		location.y -= 1
	if Input.is_action_pressed('down'):
		location.y += 1
	if Input.is_action_pressed('left'):
		direction = (direction - 1) % 4
	if Input.is_action_pressed('right'):
		direction = (direction + 1) % 4