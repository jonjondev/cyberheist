extends Label

var awake = false
var regex_alphabetical = RegEx.new()

var character_input_map = {
	'QuoteLeft': '`',
	'Minus': '-',
	'Equal': '=',
	'BraceLeft': '[',
	'BraceRight': ']',
	'BackSlash': '\\',
	'Semicolon': ';',
	'Apostrophe': '\'',
	'Comma': ',',
	'Period': '.',
	'Slash': '/',
	'Space': ' ',
	'Shift+1': '!',
	'Shift+2': '@',
	'Shift+3': '#',
	'Shift+4': '$',
	'Shift+5': '%',
	'Shift+6': '^',
	'Shift+7': '&',
	'Shift+8': '*',
	'Shift+9': '(',
	'Shift+0': ')',
	'Shift+QuoteLeft': '~',
	'Shift+Minus': '_',
	'Shift+Equal': '+',
	'Shift+BraceLeft': '{',
	'Shift+BraceRight': '}',
	'Shift+BackSlash': '|',
	'Shift+Semicolon': ':',
	'Shift+Apostrophe': '"',
	'Shift+Comma': '<',
	'Shift+Period': '>',
	'Shift+Slash': '?',
}

onready var timer = $Timer
var cursor_on = false
var blink_freeze = 0

func _ready():
	text = "\n> "
	regex_alphabetical.compile("^[A-Za-z]")
	timer.connect("timeout", self, "blink")

func blink():
	if blink_freeze > 0:
		blink_freeze -= 1
	else:
		var cursor_pos = text.find_last("█")
		if cursor_pos != -1:
			text = text.replace("█", "")
		else:
			text = text + "█"
		cursor_on = not cursor_on

func _input(event):
	if awake:
		if event is InputEventKey and event.pressed:
			var event_key = event.as_text()
			var new_char = ""
			var special_character = character_input_map.get(event_key)
			if special_character:
				new_char = special_character
			elif event_key.length() == 1:
				new_char = event.as_text().to_lower()
			elif event_key == "Enter":
				var line = text.substr(text.find_last("\n> ") + 3, text.length())
				new_char = "\n" + get_response(line) + "\n> "
			elif event_key == "BackSpace":
				if text.substr(text.length() - 4, text.length()) != "\n> ":
					start_blink_freeze()
					text = text.left(text.length() - 2) + "█"
			elif event_key.begins_with("Shift+"):
				var stripped_event_key = event_key.replace("Shift+", "")
				if stripped_event_key.length() == 1 and regex_alphabetical.search(stripped_event_key):
					new_char = stripped_event_key
			if new_char:
				start_blink_freeze()
				text = text.insert(text.length() - 1, new_char)

func start_blink_freeze():
	blink_freeze = 1
	text = text.replace("█", "")
	text = text + "█"
	cursor_on = true

func get_response(line):
	var response
	if line == "--help":
		response = "git gud, scrub!"
	elif line == "cd /":
		response = "changing directories..."
	elif line == "l":
		response = "listing items..."
	else:
		if line.length() > 0:
			response = "command not found: " + line
		else:
			response = ""
	return response





