extends Node2D

onready var file = 'res://art/Words.txt'

var words = []

var cursor = load('res://art/assets/Cursors/cursor.png')
var cursor_p = load('res://art/assets/Cursors/cursor_p.png')

func _ready():
	load_file(file)

func load_file(file):
	Input.set_custom_mouse_cursor(cursor)
	var f = File.new()
	f.open(file, File.READ)
	while not f.eof_reached():
		var line = f.get_line()
		words.append(line)
		
func _physics_process(delta):
	if Input.is_action_pressed("mouse_click"):
		Input.set_custom_mouse_cursor(cursor_p)
	else:
		Input.set_custom_mouse_cursor(cursor)
	pass
