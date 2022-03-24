extends Node2D

# pretty obivious
var consonants = ['b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z']
var vowels = ['a', 'e', 'i', 'o', 'u']

# messages' arrays
var alused = ['You have already used this word', 'Duplicate words are not allowed', 'This word is already used']
var notexits = ["this word doesn't exit, dummy", 'Cannot find it']
var conlvl1 = ['Eh...', 'seen better', 'try harder', 'piece of cake']
var conlvl2 = ['good', 'nice', 'Ok', 'not bad']
var conlvl3 = ['Excellent!', 'Well Done!', 'Splendid!', 'Fantastic']
var conlvl4 = ['You are outta this world!', 'Genius!', 'WoW! Amazing!', 'Are you even a human?']

# for buttons
var button_n = load('res://art/assets/Button Icons/button_n.png')
var button_h = load('res://art/assets/Button Icons/button_h.png')
var button_p = load('res://art/assets/Button Icons/button_p.png')

# for sfx
var click1 = load('res://aud/misc/Clicks/office-calculator-single-button-press.mp3')
var click2 = load('res://aud/misc/Clicks/zapsplat_office_calculator_button_press_single_001_11983.mp3')
var click3 = load('res://aud/misc/Clicks/zapsplat_office_calculator_button_press_single_002_11984.mp3')
var clicks = [click1, click2, click3]

# node variables
onready var sfx = $sfx/sfx
onready var con4con = $CL/Con4Con
onready var con4vow = $CL/Con4Vow
onready var board = $CL/Board
onready var wohis = $CL/WordHistory
onready var message = $CL/message
onready var score = $CL/Score

# normal variables
var checker : String
var wohisarr = []
var mainconcount = 20
var mainvowcount = 7
var rng = RandomNumberGenerator.new()
var usedletter = []
var accept_gate = false
var concount 
var vowcount 
var theme = load("res://art/Themes n Fonts/maintheme.tres")
var mscore : int
var score_multiplier : int

func _ready():
	rng.randomize()
	for _i in range(0,mainconcount):
		_button_generator(20, consonants, "_button_pressed", con4con)

	for _j in range(0,mainvowcount):
		_button_generator(4, vowels, "_button1_pressed", con4vow)

func _physics_process(_delta):
	concount = con4con.get_children().size()
	vowcount = con4vow.get_children().size()
	if accept_gate == true:
		if concount < mainconcount:
			var realcount = mainconcount - concount
			for i in range(0,realcount):
				_button_generator(20, consonants, "_button_pressed", con4con)
		else: pass
		if vowcount < mainvowcount:
			var realcount = mainvowcount - vowcount
			for j in range(0,realcount):
				_button_generator(4, vowels, "_button1_pressed", con4vow)
		else: pass
		accept_gate = false

# Consonants' buttons
func _button_pressed(toggled: bool, button: Button):
	play_click()
# for button pressing and toggle
	if toggled:
		con4con.remove_child(button)
		board.add_child(button)
	else:
		board.remove_child(button)
		con4con.add_child(button)

# Vowels' butons
func _button1_pressed(toggled: bool, button1 : Button):
	play_click()
# for button pressing and toggle
	if toggled:
		con4vow.remove_child(button1)
		board.add_child(button1)
	else:
		board.remove_child(button1)
		con4vow.add_child(button1)

# Accept function
func _on_Accept_pressed():
	play_click()
# Putting letters into the array for checking and processing congrat lvl and score
	var letter : String
	if board.get_children().size() > 1:
		for child in board.get_children():
			letter += child.text
		var scorepoint = len(letter)
		if letter in wohisarr:
			var arrlen = len(alused) - 1
			var noti = alused[rng.randi_range(0,arrlen)]
			message.text = noti
			pass
		elif letter in Ref.words:
			wohis.text += letter + "\n" 
			wohisarr.append(letter)
			_delete_children(board)
			accept_gate = true
			var length = len(letter)
			if length <= 3:
				conlvl_and_score(conlvl1, scorepoint, 1)
				pass
			elif length <= 6 and length > 3:
				conlvl_and_score(conlvl2, scorepoint, 2)
				pass
			elif length <= 9 and length > 6:
				conlvl_and_score(conlvl3, scorepoint, 3)
				pass
			elif length > 9:
				conlvl_and_score(conlvl4, scorepoint, 4)
				pass
			pass
# Run if the word doesn't exits
		else:
			var arrlen = len(notexits) - 1
			var noti = notexits[rng.randi_range(0,arrlen)]
			message.text = noti
			pass
	else: pass

# Reroll function
func _on_Reroll_pressed():
	play_click()
	while board.get_children().size() != 0:
		_delete_children(board)
	while con4con.get_children().size() != 0:
		_delete_children(con4con)
	while con4vow.get_children().size() != 0:
		_delete_children(con4vow)
	accept_gate = true

# click sfx
func play_click():
	var click = clicks[rng.randi_range(0,2)]
	sfx.set_stream(click)
	sfx.play()

# Congrats lvl and score
func conlvl_and_score(conlvl, scorepoint, score_multiplier):
	var arrlen = len(conlvl) - 1
	var noti = conlvl[rng.randi_range(0,arrlen)]
	message.text = noti
	mscore += scorepoint * score_multiplier
	score.text = "Score: %s" % mscore

# Button Generator
func _button_generator(alcount, conorvow, button_kind, container_kind):
	var cmtrandnum = rng.randi_range(0,alcount)
	var cmtrandwords = conorvow[cmtrandnum]
	var button = Button.new()
	button.toggle_mode = true
	button.set_theme(theme)
	button.text = cmtrandwords
	button.connect("toggled", self, button_kind, [button])
	container_kind.add_child(button)
	pass

# Deleting words
func _delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
func _on_Quit_pressed():
	get_tree().quit()
