extends Skill
var use: float =100.0 
var open : bool
var bullet : Bullet

func Enter():
	open = false
	
func Exit():
	open = false

func input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			open=true
			bullet=bullet_scene.instantiate()
			bullet.position=position
			bullet.attack_damage=bullet.damage_mutiple*1.0
			add_child(bullet)
			bullet.global_position.y=320
			if Manage.active_perk[Manage.perk_id.chuizhiluoxia]:
				bullet.scale.y=-1
		else:
			open = false
			if bullet:
				bullet.queue_free()

func Update(delta : float):
	if open :
		if Manage.resources[6]>=use*delta and get_global_mouse_position().y<650:
			Manage.add_resource(6,-use*delta)
		else:
			open = false
			if bullet:
				bullet.queue_free()
