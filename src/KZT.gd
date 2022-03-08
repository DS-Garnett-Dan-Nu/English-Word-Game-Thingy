extends Node2D



var consonants = ['b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z']
var vowels = ['a', 'e', 'i', 'o', 'u']

var rng = RandomNumberGenerator.new()
var usedletter1 = []
var usedletter2 = []
var usedalphabets = []
func _ready():
	rng.randomize()
	for _i in range(0,15):
		var cmtrandnum1 = rng.randi_range(0,20)
		var cmtrandcons = consonants[cmtrandnum1]
		var button = Button.new()
		button.text = cmtrandcons

		button.connect("pressed", self, "_button_pressed", [button])

		get_node("Container4cons").add_child(button)
	
	for _j in range(0,5):
		var cmtrandnum2 = rng.randi_range(0,4)
		var cmtrandvowels = vowels[cmtrandnum2]
		
		var button1 = Button.new()
		button1.text = cmtrandvowels
		button1.connect("pressed", self, "_button1_pressed", [button1])
		get_node("Container4vowels").add_child(button1)
		

func _physics_process(delta):
	pass
	
func _button_pressed(button: Button):
	usedletter1.append(button.text)
	combiningtwoarr(usedletter1)
	button.queue_free()

func _button1_pressed(button1 : Button):
	usedletter2.append(button1.text)
	combiningtwoarr(usedletter2)
	button1.queue_free()

func combiningtwoarr(usedletters):
	usedalphabets.append_array(usedletters)
	print(usedalphabets)

