extends Skill
var cold=0.02
var use=1.0
var multiple=3
var process : float
var open : bool
func Enter():
	open = false
	process=0.0
	
func Exit():
	open = false
	process=0.0

func input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			open=true
		else:
			open = false
		process=0.0

func Update(delta : float):
	if open and Manage.resources[1]>=use:
		process=min(cold,process+delta)
		if process>=cold and Manage.resources[1]>=use:
			process-=cold
			for i in range(1,multiple+1):
				var bullet=bullet_scene.instantiate()
				bullet.position=Vector2(0,0)
				bullet.direction=(get_viewport().get_mouse_position()-position).normalized()
				var ver_direction=Vector2(bullet.direction[1],-bullet.direction[0])
				bullet.rotation=bullet.direction.angle()
				bullet.attack_damage=bullet.damage_mutiple*1.0
				if i%2:
					bullet.position+=ver_direction*10*(i/2)
				else:
					bullet.position-=ver_direction*10*(i/2)
				add_child(bullet)
			Manage.add_resource(1,-use)
