extends State
class_name Dying
@onready var hitbox_component : HitboxComponent = get_parent().get_parent().get_node("HitboxComponent")
var x_velocity
var y_velocity

func Enter():
	enemy.z_index=100
	if hitbox_component:
		hitbox_component.queue_free()
	x_velocity=50.0
	y_velocity=-200

func Exix():
	pass
	
func Update(_delta:float):
	pass

func Physics_Update(_delta:float):
	if enemy:
		enemy.position += Vector2(x_velocity,y_velocity)*_delta
		y_velocity+=Manage.gravity*_delta
		if enemy.position.y>850:
			enemy.die()
