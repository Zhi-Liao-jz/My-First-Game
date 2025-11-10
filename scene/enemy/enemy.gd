extends Node2D
class_name Enemy
@export var drop_resource :int = 0
@export var drop_money : int = 0
@export var weight : float = 10

func _ready():
	pass

func _process(delta: float) -> void:
	pass

func die():
	Manage.add_money(drop_money)
	var nodes = get_tree().get_nodes_in_group("元素条")
	var tmp = 0
	var length = (Manage.area_right - Manage.area_left) / Manage.resources_area_sum
	var area_sum : float = 0
	for i in Manage.resources_area:
		area_sum+=i
		if position.x <= Manage.area_left+length*area_sum && position.x>= Manage.area_left+length*(area_sum-i):
			Manage.add_resource(tmp,drop_resource)
		else:
			Manage.add_resource(tmp,drop_resource/10)
		tmp+=1
	queue_free()
