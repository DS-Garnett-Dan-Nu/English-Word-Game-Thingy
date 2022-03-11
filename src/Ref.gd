extends Node2D

onready var file = 'res://art/Words.txt'

var word = []

func _ready():
	load_file(file)

func load_file(file):
	var f = File.new()
	f.open(file, File.READ)
	while not f.eof_reached():
		var line = f.get_line()
		word.append(line)
