extends Skill

func input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and event.position.y<650:
		var bullet=bullet_scene.instantiate()
		bullet.position=Vector2(0,0)
		bullet.direction=event.position-position
		bullet.attack_damage=bullet.damage_mutiple*1.0
		add_child(bullet)
