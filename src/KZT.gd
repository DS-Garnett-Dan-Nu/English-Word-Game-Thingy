extends Node2D

var consonants = ['b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z']
var vowels = ['a', 'e', 'i', 'o', 'u']

onready var con4con = $CL/Con4Con
onready var con4vow = $CL/Con4Vow
onready var board = $CL/Board

var rng = RandomNumberGenerator.new()
var usedletter = []

func _ready():
	rng.randomize()
		

func _physics_process(_delta):
	var concount = con4con.get_children().size()
	
	if concount < 15:
		var cmtrandnum1 = rng.randi_range(0,20)
		var cmtrandcons = consonants[cmtrandnum1]
		var button = Button.new()
		button.set_toggle_mode(true)
		#button.toggle_mode = true
		button.text = cmtrandcons
		button.connect("toggled", self, "_button_pressed", [button])
		con4con.add_child(button)
	else: pass
	
	var vowcount = con4vow.get_children().size()
	
	if vowcount < 5:
		var cmtrandnum2 = rng.randi_range(0,4)
		var cmtrandvowels = vowels[cmtrandnum2]
		var button1 = Button.new()
		button1.toggle_mode = true
		button1.text = cmtrandvowels
		button1.connect("pressed", self, "_button1_pressed", [button1])
		con4vow.add_child(button1)
	else: pass

func _button_pressed(toggled : bool, button: Button):
	var letterindex = int()
	if toggled :
		usedletter.append(button.text)
		var i = button.text
		if i in usedletter:
			var lenn = len(usedletter)
			letterindex = lenn
			combiningtwoarr(usedletter)
		else:
			combiningtwoarr(usedletter)
			letterindex = usedletter.find(button.text,0)
		print(letterindex)
	else:
		usedletter.remove(letterindex)
		#print(letterindex)

func _button1_pressed(button1 : Button):
	usedletter.append(button1.text)
	combiningtwoarr(usedletter)

func combiningtwoarr(usedletters):
	board.text = PoolStringArray(usedletters).join("")
	print(usedletters)



