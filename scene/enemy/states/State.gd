extends Node
class_name State
signal Transitioned
var enemy : Node2D

func _ready() -> void:
	enemy=get_parent().get_parent()

func Enter():
	pass

func Exit():
	pass
	
func Update(_delta:float):
	pass

func Physics_Update(_delta:float):
	pass
