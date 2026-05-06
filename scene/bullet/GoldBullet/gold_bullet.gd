extends Bullet
@export var bullet_scene : PackedScene = preload("res://scene/bullet/GoldBullet/GoldBullet.tscn")
var split_mutiple : int = 10
var split_reduce : float = 0.5
var split_strength : float = 100
var time : float
var max_time : float
var velocity : Vector2
var strength : float 

func _ready() -> void:
	super()
	velocity=direction.normalized()*speed
	time=max_time

func _process(delta: float) -> void:
	super(delta)
	scale=Vector2(strength/100,strength/100)
	velocity=direction.normalized()*speed
	
func _physics_process(delta: float) -> void:
	super(delta)

func _on_area_entered(area: Area2D) -> void:
	super(area)
	
func fenlie() -> void:
	var every_angel : float = 2*PI/split_mutiple
	var start_angel : float = 2*PI*randf()
	for i in range(split_mutiple):
		var bullet=bullet_scene.instantiate()
		get_parent().add_child(bullet)
		bullet.strength=strength*split_reduce
		bullet.position=position
		bullet.split_strength=split_strength
		bullet.attack.attack_damage=bullet.attack_param.attack_damage*bullet.strength/100
		bullet.scale=scale*split_reduce
		var i_direction=Vector2.from_angle(start_angel+i*every_angel)
		if bullet.strength<split_strength:
			bullet.move_component.move_state=MoveComponent.move_states.velocity
			bullet.move_component.velocity=i_direction*move_component.speed
		else:
			bullet.move_component.move_state=MoveComponent.move_states.target_speed
			bullet.move_component.target_position=position+i_direction*move_component.speed
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
