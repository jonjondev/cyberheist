extends RichTextLabel

var awake = false
var regex_alphabetical = RegEx.new()
var online = false
var locked_dir = null
var ttd = null
var in_sim = false

var dirs = {
	'local_dir': {
		'welcome.txt': "Hello, my friend!\n\nI am glad you have received my gift and successfully booted the system. I apologise for my previous lack of explanation however due to my effective retirement, I wished to pass along the tools of my livlihood to the younger generation, namely you. I've spent many fond hours on my Gridripper and feel compelled to pay it forward to someone such as yourself.\n\nIf you're reading this, then you must have figured out some of the cammands or at least how to view and open files - I knew you'd have the chops for this. I've left additional instructions on how to use this old beauty, however you can see a full list of commands by typing \"help\" if you wish. As you might have figured out, you can see a list of items in your current directory using the \"list\" command, and I suggest taking a look at some of the files in the instructions directory using \"goto\" (followed by the directory name).\n\nSee you there!",
		'/instructions': {
			'../': 'local_dir',
			'next_step.txt': "Good job on making your way here. As you can see, computers are structured like a tree; full of files and directories that contain more files and directories. However now that you're inside a directory, you might be wondering how to get out of one. Well the simple answer is using the same \"goto\" command you used to get here, however you need to execute it on a special kind of directory which points to the folder that you came from called \"../\". Once you get back to the root directory you came from, you can open up the memories directory for something a little different. The password for the directory is \"open-sesame\".",
		},
		'/memories': {
			'../': 'local_dir',
			'password': 'open-sesame',
			'about_memories.txt': "Excellent work on getting this far. Now's the fun part where I get to show you how to zip your way through the grid and you can see what this machine can really do!\n\nSo sometimes you'll need access to information on a system that is out of your reach, such as the password to the secrets directory in the home directory above you. This information is out of the user's purview, being held in system memory. The Gridripper, however, is a special piece of kit that can identify \"memory fragments\" that act like a backdoor to hidden information. These fragments can be seen with the \"list\" command and are prefixed with the @ symbol, followed by a memory value. In identifying them, the Gridripper can also simulate the computer's memory (using the \"simulate\" command), giving you access to the grid, where you'll be able to find all sorts of useful information. When you're in the simulation, you'll be able to use the arrow keys to navigate around.\n\nCheck out the memory fragment here to see if you can find the password for the secrets directory and we'll meet again there.",
			'@1475': {
				'player_loc': Vector2(1, 3),
				'player_dir': 0,
				'wall_map': [
							["■", "■", "■", "■"],
							["■", " ", " ", "■"],
							["■", " ", "■", "■"],
							["■", " ", "■", "■"],
							["■", "■", "■", "■"],],
				'entities': {},
				'secrets': {
					Vector2(2, 1): '123',
				},
			},
		},
		'/secrets': {
			'../': 'local_dir',
			'password': '123',
			'the_secret.txt': "So in seeing the real power of the Gridripper, I feel I now owe you something of a secret about me. For my entire career navigating the grid for the big corporates, I've been doing a little something else in my spare time to sure up my retirement plans... I guess you could say... charging them a small, hidden fee.\n\nIt's mostly harmless to megacorporations such as themselves and I'm sure you'll find someone who'd happily see it as a service to society anyway.\n\nSo yes, that would be it then. The guilty past-time of an old console cowboy like myself.",
			'networks.txt': "So the final thing I think you should know about the computer is how to connect to networks. I mean browsing these few files I've left you would be rather drab after a while anyway.\n\nTo connect to a network you use the \"connect\" command, followed by a network name. Once you connect to a network, it will be saved in a list of known networks that you can see with the \"networks\" command. Once you connect to a network, you will be given a time-til-disconnect, this is the maximum amount of time you will be allowed to stay connected to the network before being booted off.\n\nYou can try this out by connecting to a network I've set up for you to play around with by the name of \"safe_harbour\"",
		},
	},
	'available_networks': {},
	'hidden_networks':  {
		'safe_harbour': {
			'ttd': 60,
			'copying.txt': "As you can see, we have limited time here, as dictated by the network rules, so I recommend you use the \"copy\" command on the other text file with my final notes so you can ready it back on the local system. To disconnect before the time runs out, simply use the \"disconnect\" command.",
			'final_note.txt': "Well done to you! You've successfully jumped through all these little hoops I've set up for you but now you should know all of the basic functions of my beloved Gridripper. Please put her to good use and I'm sure she'll treat you right.\n\nIn terms of where to go from here, that's completely up to you, however if you arent off-put by my guilty pleasure, I'd start by taking a peek at (and maybe a few hundred thousand of) InterCorp's accounts department (network name \"intercorp_accounts\"). Remember, if you see any account details, be sure to copy them to your local machine. It shouldn't be too hard and I'm sure it'll be a fun, little experience.\n\nHappy hacking,\nConsole Cowboy Extraordinaire, J.M.",
		},
		'intercorp_accounts': {
			'ttd': 180,
			'/transfers': {
				'../': 'available_networks/intercorp_accounts',
				'password': 'pass2404inter!',
				'transfer_details.txt': "ACCT#: 23470928 43287070\nACCESS_KEY:G7HHD89YPP3",
			},
			'/jeffm_pc': {
				'../': 'available_networks/intercorp_accounts',
				'password': 'jeffiscool',
				'auths_feb.txt': "* Ventech Inc. - (2/2) [APPROVED]\n* InterCorp EU - (8/2) [APPROVED]\n* ExpressCard - (14/2) [APPROVED]\n* Blackwater Consulting - (23/2) [APPROVED]",
				'auths_mar.txt': "* Mensako Industries - (4/3) [PENDING]\n* Unibanker - (12/3) [APPROVED]\n* Bond Mining Corp. - (13/3) [PENDING]\n* INexus - (15/3) [APPROVED]",
				'sales_cossref_mar.txt': "* Mensako Industries --> Bond Mining Corp. =[DEDUCT] 10.5%\n* Unibanker --> Bond Mining Corp. =[DEDUCT] 45%",
				'jenny_is_a_dork.txt': "\nMarch 16 at 14:03:57\nJeff, this is a HUGE BREACH OF SECURITY!\nWhile it is 1. absolutely not acceptable to have the client perform\nYOUR JOB, it is 2. AGAINST COMPANY POLICY to email out\ninternal passwords. I will have to report this to security immediately.\n\nRegards,\nJenny Radcove\n>>> March 16 at 13:24:01\n>>> Hey Mike, you can get the transfer detail yourself if you need\n>>> from the transfers folder. Password is “pass2404inter!” Actually\n>>> let me check that wth Jenny that might not be right haha.. Ccd here\n>>>\n>>> Jeff\n>>>>>> March 14 at 13:24:01\n>>>>>> Hi Jeff,\n>>>>>>\n>>>>>> This is Michael from Bond Mining and we’re still waiting\n>>>>>> on transfer approval from your team to receive the funds. Please\n>>>>>> send through the payment ASAP as we have clients waiting on us.\n>>>>>>\n>>>>>> Regards,\n>>>>>> Michael Bradick, Finances & Accounting Dept.",
			},
			'/jennyr_pc': {
				'../': 'available_networks/intercorp_accounts',
				'password': 'mdopx23&',
				'transfers_feb.txt': "* Ventech Inc. (2/2) - $230,000,000\n* InterCorp EU (8/2) - $8,000,000\n* ExpressCard (14/2) - $32,000,000\n* Blackwater Consulting (23/2) - $750,000",
				'transfers_mar.txt': "* Unibanker (12/3) - $1,000,000\n* INexus (15/3) - $20,750,000",
				'hr_report_3.txt': "TO: InterCorp Human Resources Department\nFROM: Jenny Radcove, InterCorp Accounts Department\n\nAs per my previous complaints, I would once again like to inform you of recent incidents involving my coworker, Jeff Malincoph. While I have previously made it clear that his immature behaviour and complete lack of professionalism is detrimental to this company, he has also been a personal nuisance to myself and others in the department. Last week he got to work late and hungover beyond acceptable and reasonable limits and proceeded to snore loudly at his desk. Upon being woken up, he proceeded to yell at our printer and eat two other staff's packed lunches from the communal fridge.\n\nRegards,\nJenny Radcove",
				'hr_report_4.txt': "TO: InterCorp Human Resources Department\nFROM: Jenny Radcove, InterCorp Accounts Department\n\nI apologise in adnace for the forwardness of the letter, however I request that my coworker, Jeff Malincoph, has his contract terminated effective immediately. Yesterday Jeff's hangover mischiefs reached a new low, as he has apparently slept under his desk overnight and potentially soiled himself in the process. Today he has been more confrentational and uncaring of responsibilities than usual, even going so far as to leak sensitive information to a client. This is the last time I will be writing to HR in this capacity before escalating the matter above your department's level of control.\n\nRegards,\nJenny Radcove",
				'clients_q1.txt': "* Blackwater Consulting\n* Ventech Inc.\n* InterCorp EU\n* ExpressCard\n* Bank of India",
				'clients_q2.txt': "* Mensako Industries\n* Unibanker\n* INexus\n* Holdsfort Banking\n* Bond Mining Corp.",
			},
			'@1201': {
				'player_loc': Vector2(3, 4),
				'player_dir': 1,
				'wall_map': [
							["■", "■", "■", "■", "■", "■", "■", "■", "■", "■"],
							["■", " ", " ", " ", " ", " ", " ", " ", " ", "■"],
							["■", "■", " ", "■", " ", "■", "■", "■", " ", "■"],
							["■", "■", "■", "■", " ", "■", " ", " ", " ", "■"],
							["■", "■", "■", " ", " ", "■", "■", " ", "■", "■"],
							["■", "■", "■", "■", "■", "■", "■", "■", "■", "■"],],
				'entities': {
					Vector2(1, 1): 1,
					Vector2(6, 3): 1,
				},
				'secrets': {
					Vector2(2, 2): 'jeffiscool',
					Vector2(6, 3): 'mdopx23&',
				},
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
var start_times = 0

func _ready():
	regex_alphabetical.compile("^[A-Za-z]")
	$StartDelay.connect("timeout", self, "on_system_start")

func on_system_start():
	if start_times == 0:
		text = "\nStarting system..."
		$"../../../Start".play()
	elif start_times == 1:
		text = text + "\nInitialising system commands..."
	elif start_times == 2:
		text = text + "\n\nCopyright (C) 1997 Whitehat Systems\nPlatform: x12_42-pc-gridripper-pro (56kb)\n"
	elif start_times == 4:
		var time = str(OS.get_time().hour) + ":" + str(OS.get_time().minute) + ":" + str(OS.get_time().second)
		text = text + "\nSystem started successfully at " + time
		text = text + '\nType "help" for a list of avalable commands'
	elif start_times == 6:
		text = text + "\n> "
		cursor_blink_timer.connect("timeout", self, "blink")
		ttd_timer.connect("timeout", self, "countdown")
		awake = true
		$StartDelay.stop()
	start_times += 1

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
			network_disconnect()

func network_disconnect(manual_disconnect = false):
	$TTDTimer.stop()
	if in_sim:
		$"../../../Node2D".toggle_view()
		$"../../../Node2D/Grid".reset_grid()
		in_sim = false
	start_blink_freeze()
	if not manual_disconnect:
		text = text.replace("█", "").insert(text.find_last("\n> "), "\ndisconnected from network...")
	text = text.replace("\nconnected, time til disconect: " + str(ttd) + "s", "\nconnected, time til disconect: -")
	online = false
	ttd = null
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
				response = "Commands:\n - help: displays the help menu\n - clear: clears all text currently displayed on the terminal screen\n - list: displays all files in the current directory\n - view: displays the contents of a given file in the current directory, takes 1 arg for filename\n - goto: opens a given directory, takes 1 arg for directory name\n - copy: copies a file to the root of your local machine (will overwrite files by the same name), takes 1 arg for filename\n - networks: displays all known network names\n - connect: connects to any remote network (known or unknown), takes 1 arg for network name\n - disconnect: disconnects from the current network\n - simulate: runs a grid-simulation on a given memory fragment, takes 1 arg for memory fragment name\n---------------------------"
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
					var networks = dirs['available_networks'].keys()
					if networks.size() > 0:
						response = PoolStringArray(networks).join("\n")
					else:
						response = "networks: no known networks found"
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
						response = "connect: network unknown\nsearching for new networks...\n"
						network = dirs['hidden_networks'].get(line[1])
						if network:
							dirs['available_networks'][line[1]] = network
							text = text.replace("\nconnected, time til disconect: " + str(ttd) + "s", "\nconnected, time til disconect: -")
							ttd = network['ttd']
							$TTDTimer.start()
							response =  response + "connecting to network...\nconnected, time til disconect: " + str(ttd) + "s"
							online = true
							current_dir = network
						else:
							response = response + "connect: network not found"
			"disconnect":
				if online:
					var arg_error = check_arguments(line, "view", 0)
					if arg_error: 
						response = arg_error
					else:
						response = "disconnecting from network..."
						network_disconnect(true)
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
			"copy":
				var arg_error = check_arguments(line, "copy", 1)
				if arg_error: 
					response = arg_error
				else:
					var file = current_dir.get(line[1])
					if file:
						if line[1].ends_with(".txt"):
							if line[1] == 'transfer_details.txt':
								response = "\n\nGAME OVER, YOU WIN\n\nThanks for playing CyberHeist, if you liked playing the game, please let me know! Feel free to reach out to me on Twitter @JonJonRespawned with any feedback you have.\n\n"
								awake = false
							else:
								dirs['local_dir'][line[1]] = file
								response = "file coppied to local system"
						else:
							response = "copy: not a file"
					else:
						response = "copy: file not found"
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
							$"../../../Node2D/Grid".set_simulation(memory)
							$"../../../Node2D".toggle_view()
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
