extends RichTextLabel

var awake = true
var regex_alphabetical = RegEx.new()
var online = false
var locked_dir = null
var ttd = null
var in_sim = false

var dirs = {
	'local_dir': {
		'welcome.txt': "Welcome to CyberHeist!",
	},
	'available_networks': {
		'pentagon': {
			'ttd': 20,
			'welcome.txt': "Welcome to the pentagon's secret stash!'",
			'dontopen.txt': "Give your balls a tug, you tit-fucker!",
			'/secrets': {
				'../': 'available_networks/pentagon',
				'password': '123',
				'secret.txt': "This was a decoy, you dumby!",
			},
			'@1475': {
				'player_loc': Vector2(1, 3),
				'player_dir': 0,
				'wall_map': [
							["■", "■", "■", "■"],
							["■", " ", " ", "■"],
							["■", " ", "■", "■"],
							["■", " ", "■", "■"],
							["■", "■", "■", "■"],],
				'entity_map': [
							[" ", " ", " ", " "],
							[" ", "x", " ", " "],
							[" ", " ", " ", " "],
							[" ", " ", " ", " "],
							[" ", " ", " ", " "],],
			},
		},
	}
}

var current_dir = dirs['local_dir']

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

onready var cursor_blink_timer = $CursorBlinkTimer
onready var ttd_timer = $TTDTimer
var cursor_on = false
var blink_freeze = 0

func _ready():
	text = "\n> "
	regex_alphabetical.compile("^[A-Za-z]")
	cursor_blink_timer.connect("timeout", self, "blink")
	ttd_timer.connect("timeout", self, "countdown")

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

func countdown():
	if ttd:
		ttd -= 1
		text = text.replace("\nconnected, time til disconect: " + str(ttd+1) + "s", "\nconnected, time til disconect: " + str(ttd) + "s")
		if ttd <= 0:
			$TTDTimer.stop()
			if in_sim:
				$"../../Node2D".toggle_view()
			text = text.replace("\nconnected, time til disconect: " + str(ttd) + "s", "\nconnected, time til disconect: -")
			start_blink_freeze()
			text = text.replace("█", "").insert(text.length()-4, "\ndisconnected from network...")
			online = false
			current_dir = dirs['local_dir']

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
				start_blink_freeze()
				var line
				if locked_dir:
					line = text.substr(text.find_last("\npassword: ") + 11, text.length()).replace("█", "")
				else:
					line = text.substr(text.find_last("\n> ") + 3, text.length()).replace("█", "")
				new_char = get_response(line)
			elif event_key == "BackSpace":
				start_blink_freeze()
				if text.substr(text.length()-4, text.length()).replace("█", "") != "\n> " and text.substr(text.length()-12, text.length()).replace("█", "") != "\npassword: ":
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
	line = line.lstrip(" ").rstrip(" ").split(" ")
	var response
	if locked_dir:
		if line[0] == locked_dir['password']:
			current_dir = locked_dir
			response = "opening directory..."
		else:
			response = "password incorrect"
		locked_dir = null
	else:
		match line[0]:
			"help":
				response = "Commands:\n - help: displays the help menu, takes 0 args\n - list: displays all files in the current directory, takes 0 args\n - view: displays the contents of a given file in the current directory, takes 1 arg for filename\n - clear: clears the contents of the terminal output, takes 0 args\n---------------------------"
			"list":
				var arg_error = check_arguments(line, "list", 0)
				if arg_error: 
					response = arg_error
				else:
					var keys = current_dir.keys()
					keys.erase("password")
					keys.erase("ttd")
					response = PoolStringArray(keys).join("\n")
			"networks":
				var arg_error = check_arguments(line, "list", 0)
				if arg_error: 
					response = arg_error
				else:
					response = PoolStringArray(dirs['available_networks'].keys()).join("\n")
			"connect":
				var arg_error = check_arguments(line, "view", 1)
				if arg_error: 
					response = arg_error
				else:
					var network = dirs['available_networks'].get(line[1])
					if network:
						text = text.replace("\nconnected, time til disconect: " + str(ttd) + "s", "\nconnected, time til disconect: -")
						ttd = network['ttd']
						$TTDTimer.start()
						response = "connecting to network...\nconnected, time til disconect: " + str(ttd) + "s"
						online = true
						current_dir = network
					else:
						response = "connect: network not found"
			"disconnect":
				if online:
					var arg_error = check_arguments(line, "view", 0)
					if arg_error: 
						response = arg_error
					else:
						response = "disconnecting from network..."
						online = false
						current_dir = dirs['local_dir']
				else:
					response = "disconnect: you are not online"
			"view":
				var arg_error = check_arguments(line, "view", 1)
				if arg_error: 
					response = arg_error
				else:
					var file = current_dir.get(line[1])
					if file:
						if line[1].ends_with(".txt"):
							response = file
						else:
							response = "view: not a file"
					else:
						response = "view: file not found"
			"clear":
				var arg_error = check_arguments(line, "clear", 0)
				if arg_error: 
					response = arg_error
				else:
					response = ""
					text = ""
			"goto":
				var arg_error = check_arguments(line, "goto", 1)
				if arg_error: 
					response = arg_error
				else:
					var directory = current_dir.get(line[1])
					if directory:
						if line[1].begins_with("/"):
							if directory.get('password'):
								locked_dir = directory
								start_blink_freeze()
								text = text.replace("█", "")
								text = text + "\npassword: █"
							else:
								response = "opening directory..."
								current_dir = directory
						elif line[1] == "../":
							response = "opening directory..."
							var path = directory.split("/")
							current_dir = dirs
							for step in path:
								current_dir = current_dir[step]
						else:
							response = "goto: " + line[1] + " is not a directory"
					else:
						response = "goto: no such directory"
			"simulate":
				var arg_error = check_arguments(line, "simulate", 1)
				if arg_error: 
					response = arg_error
				else:
					var memory = current_dir.get(line[1])
					if memory:
						if line[1].begins_with("@"):
							response = "loading memory..."
							in_sim = true
							$"../../Node2D/Grid".set_simulation(memory)
							$"../../Node2D".toggle_view()
						else:
							response = "simulate: not a memory fragment"
					else:
						response = "simulate: memory fragment not found"
			_:
				if line[0] != "":
					response = "command not found: " + line[0]
				else:
					response = ""
	if not locked_dir:
		if response != "":
			response = response.insert(0, "\n")
		response = response + "\n> "
	return response

func check_arguments(line, func_name, expected_args):
	if line.size() - 1 != expected_args:
		return func_name + ": incorrect number of arguments, expected " + str(expected_args)
