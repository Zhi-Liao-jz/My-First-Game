extends Node2D
class_name Enemy
@export var param : EnemyParam
@export var move_component : MoveComponent

func _ready():
	move_component.speed = param.speed

func _process(delta: float) -> void:
	pass

func die():
	Manage.add_money(param.drop_money)
	var tmp = 0
	var length = (Manage.area_right - Manage.area_left) / Manage.resources_area_sum
	var area_sum : float = 0
	for i in Manage.resources_area:
		area_sum+=i
		if position.x <= Manage.area_left+length*area_sum && position.x>= Manage.area_left+length*(area_sum-i):
			Manage.add_resource(tmp,param.drop_resource)
		else:
			Manage.add_resource(tmp,param.drop_resource/10)
		tmp+=1
	queue_free()
