extends Skill
var cold : float = 0.1
var use : float = 10.0
var process : float
var open : bool
@export var bomb_bullet_scene : PackedScene
func Enter():
	open = false
	process=0.0
	
func Exit():
	open = false
	process=0.0

func input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if Manage.active_perk[Manage.perk_id.fire_bomb] and Manage.resources[0]>=20*use and get_global_mouse_position().y<650:
				var bullet=bomb_bullet_scene.instantiate()
				bullet.global_position=global_position
				bullet.target_position=event.position
				bullet.be_fired()
				bullet.attack_damage=bullet.damage_mutiple*1.0
				get_tree().current_scene.add_child(bullet)
				Manage.add_resource(0,-20*use)
			else:
				open=true
		else:
			open = false
		process=0.0

func Update(delta : float):
	if open and Manage.resources[0]>=use and Manage.active_perk[Manage.perk_id.fire_bomb]==0 and get_global_mouse_position().y<650:
		process+=delta
		while process>cold and Manage.resources[0]>=use:
			process-=cold
			var bullet=bullet_scene.instantiate()
			bullet.global_position=global_position
			bullet.direction=(get_global_mouse_position()-global_position).rotated(randf()*PI/3-PI/6)
			bullet.attack_damage=bullet.damage_mutiple*1.0
			if Manage.active_perk[Manage.perk_id.fire_xiajibashe] :
				bullet.speed*=2
				bullet.fire_strength_decrease_time *= 0.8
				bullet.fire_strength*=2
				bullet.direction=(get_global_mouse_position()-global_position).rotated(randf()*PI-PI/2)
				bullet.damage_mutiple*=2
			
			get_tree().current_scene.add_child(bullet)
			Manage.add_resource(0,-use)
