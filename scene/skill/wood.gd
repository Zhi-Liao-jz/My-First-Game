extends Skill
var use=100

func input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and event.position.y<650 and Manage.resources[2]>=use:
		var bullet=bullet_scene.instantiate()
		bullet.position=event.position
		bullet.attack_damage=bullet.damage_mutiple*1.0
		add_child(bullet)
		Manage.add_resource(2,-use)
