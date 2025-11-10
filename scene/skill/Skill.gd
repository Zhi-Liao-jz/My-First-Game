extends Node2D
class_name Skill
@export var bullet_scene : PackedScene
@export var icon : Texture
signal spawn_bullet(add_resource:int)

func Enter():
	pass

func Exit():
	pass
	
func Update(_delta:float):
	pass

func Physics_Update(_delta:float):
	pass
	
func input(event: InputEvent):
	pass
