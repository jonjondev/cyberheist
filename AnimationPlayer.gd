extends AnimationPlayer

var minimised = false

func _input(event):
	if Input.is_action_pressed('tab'):
		if minimised:
			play("maximise")
		else:
			play("minimise")
		minimised = not minimised