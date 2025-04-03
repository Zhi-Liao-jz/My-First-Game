extends Node2D
class_name Enemy
@export var drop_resource : Array[float] = [0,0,0,0,0,0,0]
@export var drop_money : int = 0
@export var weight : float = 10

func _ready():
	print(drop_resource[0])

func _process(delta: float) -> void:
	pass

func die():
	Manage.add_money(drop_money)
	for i in range(7):
		Manage.add_resource(i,drop_resource[i])
	queue_free()
