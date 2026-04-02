extends Skill

func input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and event.position.y<650:
		var bullet=bullet_scene.instantiate()
		bullet.global_position=global_position
		bullet.direction=event.position-global_position
		bullet.attack_damage=bullet.damage_mutiple*1.0
		get_tree().current_scene.add_child(bullet)
