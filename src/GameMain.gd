extends Node2D

var a = false

onready var Board = $CanvasLayer/Board
onready var A = $CanvasLayer/VowelContainer/A
onready var VC = $CanvasLayer/VowelContainer

func _on_A_pressed():
	Board.text = "A"
	VC.remove_child(A)
	a = true

func _physics_process(delta):
	if a == true:
		VC.add_child(A)
		a= false
