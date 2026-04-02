extends Skill
var use: float =1000.0 

func input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and event.position.y<650:
		if Manage.resources[5]>=use:
			Manage.resources[5]-=use
			var bullet=bullet_scene.instantiate()
			bullet.global_position=global_position
			bullet.attack_damage=bullet.damage_mutiple*1.0
			get_tree().current_scene.add_child(bullet)
			bullet.global_position.y=200
			if not Manage.active_perk[Manage.perk_id.chuizhiluoxia]:
				bullet.position.x+=50
