extends Area2D
@export var damage_mutiple = 1.0
@export var speed = 200.0
@export var bullet_scene : PackedScene = preload("res://scene/bullet/GoldBullet/GoldBullet.tscn")
var split_mutiple : int = 10
var split_reduce : float = 0.5
var split_strength : float = 100
var time : float
var max_time : float
var attack_damage : float
var direction : Vector2
var velocity : Vector2
var strength : float 
func _ready() -> void:
	velocity=direction.normalized()*speed
	time=max_time

func _process(delta: float) -> void:
	scale=Vector2(strength/100,strength/100)
	velocity=direction.normalized()*speed
	
func _physics_process(delta: float) -> void:
	time-=delta
	position+=velocity*delta
	if time<=0:
		if strength>split_strength:
			var every_angel : float = 2*PI/split_mutiple
			var start_angel : float = 2*PI*randf()
			for i in range(split_mutiple):
				var bullet=bullet_scene.instantiate()
				bullet.position=position
				bullet.direction=Vector2.from_angle(start_angel+i*every_angel)
				bullet.max_time=max_time
				bullet.strength=strength*split_reduce
				bullet.split_strength=split_strength
				bullet.attack_damage=bullet.damage_mutiple*bullet.strength/100
				bullet.scale=scale*0.5
				get_parent().add_child(bullet)
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		var attack = Attack.new()
		attack.attack_damage=attack_damage
		area.damage(attack)
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
