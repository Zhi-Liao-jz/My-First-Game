extends Bullet
var target_position : Vector2
var tween : Tween
var xiajiba_tween_rotation : Tween
var xiajiba_tween_v : Tween
var color_tween : Tween
var rotate_v : float = 1.0
var v : float = 1.0
@export var bullet_scene : PackedScene
@export var piece_scene : PackedScene
var xiajibashe = false
var can_bomb = true
@export var piece_position : Array[Vector2] 

func _physics_process(delta: float) -> void:
	if xiajibashe:
		position+=Vector2.from_angle(rotation)*delta*v*400
		rotate(rotate_v*delta*5)
	else:
		rotate(PI*delta*rotate_v)
	pass

func be_fired() -> void:
	if tween:
		tween.kill()
	tween=create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_IN)
	tween.tween_property(self,"global_position",target_position,1.0)
	tween.tween_callback(bomb).set_delay(0)

func bomb() -> void:
	rotate_v=1.0
	if Manage.active_perk[Manage.perk_id.fire_xiajibashe] :
		xiajiba_bomb()
		return
	if tween:
		tween.kill()
	tween=create_tween().set_loops(10)
	tween.set_parallel(true)
	tween.tween_callback(fire).set_delay(0.05)
	tween.tween_callback(fire).set_delay(0.05)
	rotate_v=13
	await get_tree().create_timer(0.5).timeout
	queue_free()

func xiajiba_bomb() -> void:
	if tween:
		tween.kill()
		xiajibashe = true
	if xiajiba_tween_rotation:
		xiajiba_tween_rotation.kill()
	if xiajiba_tween_v:
		xiajiba_tween_v.kill()
	if color_tween:
		color_tween.kill()
	xiajiba_tween_rotation=create_tween().set_loops(20)
	xiajiba_tween_rotation.tween_callback(rand_rotation).set_delay(randf()*0.4)
	xiajiba_tween_v=create_tween().set_loops(20)
	xiajiba_tween_v.tween_callback(rand_v).set_delay(randf()*0.4)
	color_tween=create_tween().set_ease(Tween.EASE_IN)
	color_tween.set_parallel(true)
	color_tween.tween_property($Sprite2D,"self_modulate",Color(18.892, 18.892, 0.0),4)
	color_tween.tween_property(self,"scale",Vector2(2,2),4)
	tween=create_tween().set_loops(400)
	tween.tween_callback(xiajiba_fire).set_delay(0.1)
	await get_tree().create_timer(4).timeout
	bao_fa_si_san()
	queue_free()
	
func bao_fa_si_san() -> void:
	for i in range(4):
		var piece=piece_scene.instantiate()
		get_parent().add_child(piece)
		piece.get_node("Sprite2D").region_rect=Rect2(Vector2(16,16)+piece_position[i],Vector2(32,32))
		piece.direction=piece_position[i].rotated(global_rotation+PI/2)
		piece.global_position=global_position+piece_position[i].rotated(global_rotation+PI/2)
		print(piece.global_position-global_position)
		print(piece.direction)
		piece.global_rotation=global_rotation
		piece.global_scale=global_scale

func fire() -> void:
	var bullet=bullet_scene.instantiate()
	bullet.direction=Vector2.from_angle(PI*2*randf())
	bullet.attack_damage=bullet.damage_mutiple*0.4
	get_parent().add_child(bullet)
	bullet.global_position=global_position

func xiajiba_fire() -> void:
	var bullet=bullet_scene.instantiate()
	bullet.direction=Vector2.from_angle(rotation-PI/2)
	bullet.attack_damage=bullet.damage_mutiple*0.3
	get_parent().add_child(bullet)
	bullet.global_position=global_position

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.can_be_damaged and can_bomb:
		bomb()
		can_bomb=false

func rand_rotation()->void:
	rotate_v=(randf()-0.5)*PI*2

func rand_v()->void:
	v=0.5+randf()*0.5

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	pass
