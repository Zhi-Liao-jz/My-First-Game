extends Skill
var use : float = 100
var cold : float = 1
var process : float
var charge_speed : float = 100
var open : bool
var bullet : Area2D
func Enter():
	open = false
	process=0.0
	
func Exit():
	open = false
	process=0.0
	fire()

func Update(delta : float):
	if open and Manage.resources[3]>=0:
		process+=charge_speed*delta
		Manage.add_resource(3,-use*delta)
		bullet.strength=process
		bullet.rotation+=PI*delta

func input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			open=true
			bullet=bullet_scene.instantiate()
			bullet.position=Vector2(0,0)
			bullet.direction=Vector2(0,0)
			bullet.attack_damage=0
			bullet.max_time=999999
			add_child(bullet)
		else:
			open = false
			fire()
		process=0.0
	

func fire():
	if process>10:
		var target=get_viewport().get_mouse_position()
		bullet.position=Vector2(0,0)
		bullet.direction=target-position
		bullet.attack_damage=bullet.damage_mutiple*bullet.strength/100
		bullet.max_time=(target-position).length()/bullet.speed
		bullet.time=bullet.max_time
	process=0
