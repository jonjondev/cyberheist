extends Label

#func _ready():
	#text = text + " ▋"

var shift_variants = ['!', '@', '#', '$', '%', 
					  '^', '&', '*', '(', ')']

var awake = false

func _input(event):
	if awake:
		if event is InputEventKey and event.pressed:
			var event_key = event.as_text()
			var new_char = ""
			if event_key.length() == 1:
				new_char = event.as_text().to_lower()
			elif event_key == "Space":
				new_char = " "
			elif event_key == "Period":
				new_char = "."
			elif event_key == "Enter":
				new_char = "\n> "
			elif event_key == "BackSpace":
				if text.substr(text.length() - 2, text.length()) != "> ":
					text = text.left(text.length() - 1)
			elif event_key.begins_with("Shift+"):
				event_key = event_key.lstrip("Shift+")
				if event_key.to_int() > 0 or event_key == "0":
					new_char = shift_variants[event_key.to_int()-1]
				var regex = RegEx.new()
				regex.compile("^[A-Za-z]+$")
				var result = regex.search(event_key)
				
				if result:
					new_char = event_key
				# Add modifiers here
				#new_char = "!!!"
			else:
				#new_char = event_key
				pass
			text = text + new_char