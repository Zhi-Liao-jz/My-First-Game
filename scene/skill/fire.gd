extends Skill
var cold : float = 0.1
var use : float = 10.0
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
	if open and Manage.resources[0]>=use:
		process+=delta
		while process>cold and Manage.resources[0]>=use:
			process-=cold
			var bullet=bullet_scene.instantiate()
			bullet.position=Vector2(0,0)
			bullet.direction=(get_viewport().get_mouse_position()-position).rotated(randf()*PI/3-PI/6)
			bullet.attack_damage=bullet.damage_mutiple*1.0
			add_child(bullet)
			Manage.add_resource(0,-use)
