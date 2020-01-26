extends AnimationPlayer

var minimised = false
onready var console = $"../../Console/Label"

func _input(event):
	if Input.is_action_pressed('tab'):
		if minimised:
			play("maximise")
			console.awake = false
		else:
			play("minimise")
			console.awake = true
		minimised = not minimised