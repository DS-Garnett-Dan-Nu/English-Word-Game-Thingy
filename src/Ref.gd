extends Node2D

onready var file = 'res://art/Words.txt'
onready var label = $CL/Label


func _ready():    
	load_file(file)

func load_file(file):
	var f = File.new()
	f.open(file, File.READ)
	var index = 1
	while not f.eof_reached():
		var line = f.get_line()
		line += " "
		print(line + str(index))
		index += 1
