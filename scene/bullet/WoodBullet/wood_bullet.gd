extends Bullet
@export var ray_cast : RayCast2D
@export var acceleration : float
var life_time : float = 30.0
var target : Enemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	direction=Vector2(randf(),randf())-Vector2(0.5,0.5)
	move_component.acceleration=acceleration


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation=move_component.velocity.angle()
	life_time-=delta
	if life_time<=0:
		queue_free()
	
func _physics_process(delta: float) -> void:
	if target:
		move_component.target_position=target.global_position
	ray_cast.target_position=ray_cast.target_position.rotated(2*PI*delta)
	if ray_cast.get_collider():#只检测第二层碰撞
		var collition=ray_cast.get_collider().get_parent()
		if target:
			if (target.position-position).length()>(collition.position-position).length():
				target=collition
		else:
			target=collition

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.can_be_damaged:
		area.damage(attack)
