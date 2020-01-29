extends Label

var regex_alphabetical

var shift_input_map = {
	'1': '!',
	'2': '@',
	'3': '#',
	'4': '$',
	'5': '%',
	'6': '^',
	'7': '&',
	'8': '*',
	'9': '(',
	'0': ')',
	'QuoteLeft': '~',
	'Minus': '_',
	'Equal': '+',
	'BraceLeft': '{',
	'BraceRight': '}',
	'BackSlash': '|',
	'Semicolon': ':',
	'Apostrophe': '"',
	'Comma': '<',
	'Period': '>',
	'Slash': '?',
}

func _ready():
	regex_alphabetical = RegEx.new()
	regex_alphabetical.compile("^[A-Za-z]")
	#text = text + " ▋"

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
				event_key = event_key.replace("Shift+", "")
				if event_key.length() == 1 and regex_alphabetical.search(event_key):
					new_char = event_key
				else:
					new_char = shift_input_map.get(event_key)
			else:
				#new_char = event_key
				pass
			if new_char:
				text = text + new_char