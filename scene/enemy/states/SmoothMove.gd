extends State
class_name SmoothMove
@export var speed : float

func Enter():
	pass

func Exix():
	pass
	
func Update(_delta:float):
	pass

func Physics_Update(_delta:float):
	if enemy:
		enemy.position -= Vector2(speed,0) * _delta
