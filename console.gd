extends Label

#func _ready():
	#text = text + " ▋"

func _input(event):
	if event is InputEventKey and event.pressed:
		var event_key = event.as_text()
		var new_char = ""
		if event_key.length() == 1:
			new_char = event.as_text().to_lower()
		else:
			#new_char = event_key
			pass
		text = text + new_char